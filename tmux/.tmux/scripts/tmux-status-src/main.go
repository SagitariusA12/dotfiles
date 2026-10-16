package main

import (
	"fmt"
	"hash/fnv"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"strings"
	"syscall"
	"time"
)

const (
	cBlue   = "#7aa2f7"
	cGreen  = "#9ece6a"
	cYellow = "#e0af68"
	cRed    = "#f7768e"
	cPurple = "#bb9af7"
	cCyan   = "#7dcfff"
	cGray   = "#565f89"
	cFg     = "#c0caf5"
)

type state struct {
	cpuTotal, cpuIdle uint64
	iface             string
	rx, tx            uint64
	ts                int64
}

func readHead(path string, n int) string {
	f, err := os.Open(path)
	if err != nil {
		return ""
	}
	defer f.Close()
	buf := make([]byte, n)
	m, _ := f.Read(buf)
	return string(buf[:m])
}

func readUint(path string) uint64 {
	v, _ := strconv.ParseUint(strings.TrimSpace(readHead(path, 32)), 10, 64)
	return v
}

func loadState(path string) (s state) {
	b, err := os.ReadFile(path)
	if err != nil {
		return
	}
	f := strings.Fields(string(b))
	if len(f) != 6 {
		return
	}
	s.cpuTotal, _ = strconv.ParseUint(f[0], 10, 64)
	s.cpuIdle, _ = strconv.ParseUint(f[1], 10, 64)
	s.iface = f[2]
	s.rx, _ = strconv.ParseUint(f[3], 10, 64)
	s.tx, _ = strconv.ParseUint(f[4], 10, 64)
	s.ts, _ = strconv.ParseInt(f[5], 10, 64)
	return
}

func saveState(path string, s state) {
	iface := s.iface
	if iface == "" {
		iface = "-"
	}
	data := fmt.Sprintf("%d %d %s %d %d %d", s.cpuTotal, s.cpuIdle, iface, s.rx, s.tx, s.ts)
	_ = os.WriteFile(path, []byte(data), 0o600)
}

func thresholdColor(v, warn, crit int) string {
	switch {
	case v >= crit:
		return cRed
	case v >= warn:
		return cYellow
	}
	return cGreen
}

func fmtSpeed(kb int) string {
	switch {
	case kb >= 10240:
		return fmt.Sprintf("%.1fMB", float64(kb)/1024)
	case kb >= 1024:
		return fmt.Sprintf("%.0fMB", float64(kb)/1024)
	}
	return fmt.Sprintf("%dkB", kb)
}

func readCPU() (total, idle uint64) {
	line, _, _ := strings.Cut(readHead("/proc/stat", 256), "\n")
	f := strings.Fields(line)
	if len(f) < 8 || f[0] != "cpu" {
		return
	}
	for i := 1; i < len(f) && i <= 8; i++ {
		v, _ := strconv.ParseUint(f[i], 10, 64)
		total += v
		if i == 4 || i == 5 {
			idle += v
		}
	}
	return
}

func cpuPart(old, cur state) string {
	pct := 0
	if old.cpuTotal > 0 && cur.cpuTotal > old.cpuTotal {
		dt := cur.cpuTotal - old.cpuTotal
		di := cur.cpuIdle - old.cpuIdle
		if di > dt {
			di = dt
		}
		pct = int(100 * (dt - di) / dt)
	}
	return fmt.Sprintf("#[fg=%s]󰻠 #[fg=%s]%d%%#[fg=%s]", cFg, thresholdColor(pct, 60, 85), pct, cFg)
}

func memPart() string {
	var total, avail uint64
	for _, l := range strings.Split(readHead("/proc/meminfo", 512), "\n") {
		f := strings.Fields(l)
		if len(f) < 2 {
			continue
		}
		switch f[0] {
		case "MemTotal:":
			total, _ = strconv.ParseUint(f[1], 10, 64)
		case "MemAvailable:":
			avail, _ = strconv.ParseUint(f[1], 10, 64)
		}
	}
	if total == 0 || avail > total {
		return ""
	}
	used := total - avail
	pct := int(100 * used / total)
	return fmt.Sprintf("#[fg=%s]󰍛 #[fg=%s]%.1fG#[fg=%s]", cFg, thresholdColor(pct, 60, 85), float64(used)/1048576, cFg)
}

func batPart() string {
	m, _ := filepath.Glob("/sys/class/power_supply/BAT*")
	if len(m) == 0 {
		return ""
	}
	pct, err := strconv.Atoi(strings.TrimSpace(readHead(m[0]+"/capacity", 16)))
	if err != nil {
		return ""
	}
	charging := strings.TrimSpace(readHead(m[0]+"/status", 32)) == "Charging"

	var icon, color string
	switch {
	case charging:
		icon, color = "󰂄", cGreen
	case pct >= 80:
		icon, color = "󰁹", cGreen
	case pct >= 40:
		icon, color = "󰁾", cYellow
	case pct >= 15:
		icon, color = "󰁼", cYellow
	default:
		icon, color = "󰁺", cRed
	}
	return fmt.Sprintf("#[fg=%s]%s %d%%#[fg=%s]", color, icon, pct, cFg)
}

func defaultIface() string {
	lines := strings.Split(readHead("/proc/net/route", 2048), "\n")
	for _, l := range lines[1:] {
		f := strings.Fields(l)
		if len(f) > 1 && f[1] == "00000000" {
			return f[0]
		}
	}
	return ""
}

func netPart(old, cur state) string {
	if cur.iface == "" {
		return fmt.Sprintf("#[fg=%s]󰖪 offline#[fg=%s]", cGray, cFg)
	}
	var rxKB, txKB int
	if old.iface == cur.iface && old.ts > 0 {
		dt := float64(cur.ts-old.ts) / 1e9
		if dt > 0 && cur.rx >= old.rx && cur.tx >= old.tx {
			rxKB = int(float64(cur.rx-old.rx) / 1024 / dt)
			txKB = int(float64(cur.tx-old.tx) / 1024 / dt)
		}
	}
	return fmt.Sprintf("#[fg=%s]󰖩 #[fg=%s]%s↓ %s↑", cCyan, cFg, fmtSpeed(rxKB), fmtSpeed(txKB))
}

func timePart(now time.Time) string {
	return fmt.Sprintf("#[fg=%s]󰃰 #[fg=%s]%s  #[fg=%s]%s#[fg=%s]",
		cPurple, cFg, now.Format("Mon 02/01"), cBlue, now.Format("15:04:05"), cFg)
}

func sample(now time.Time) state {
	cur := state{ts: now.UnixNano()}
	cur.cpuTotal, cur.cpuIdle = readCPU()
	if cur.iface = defaultIface(); cur.iface != "" {
		base := "/sys/class/net/" + cur.iface + "/statistics/"
		cur.rx = readUint(base + "rx_bytes")
		cur.tx = readUint(base + "tx_bytes")
	}
	return cur
}

func render(old, cur state, now time.Time) string {
	parts := make([]string, 0, 5)
	for _, p := range []string{batPart(), cpuPart(old, cur), memPart(), netPart(old, cur), timePart(now)} {
		if p != "" {
			parts = append(parts, p)
		}
	}
	sep := " #[fg=" + cGray + "]│#[fg=" + cFg + "] "
	return " " + strings.Join(parts, sep) + " "
}

func oneShot() {
	now := time.Now()
	path := filepath.Join(os.TempDir(), "tmux-status.state")
	old := loadState(path)
	cur := sample(now)
	out := render(old, cur, now)
	saveState(path, cur)
	os.Stdout.WriteString(out)
}

func acquireLock() (*os.File, error) {
	sock, _, _ := strings.Cut(os.Getenv("TMUX"), ",")
	h := fnv.New32a()
	h.Write([]byte(sock))
	name := fmt.Sprintf("tmux-status-%08x.lock", h.Sum32())
	f, err := os.OpenFile(filepath.Join(os.TempDir(), name), os.O_CREATE|os.O_RDWR, 0o600)
	if err != nil {
		return nil, err
	}
	if err := syscall.Flock(int(f.Fd()), syscall.LOCK_EX|syscall.LOCK_NB); err != nil {
		f.Close()
		return nil, err
	}
	return f, nil
}

func daemon() {
	lock, err := acquireLock()
	if err != nil {
		return
	}
	defer lock.Close()

	var old state
	for {
		now := time.Now()
		cur := sample(now)
		out := render(old, cur, now)
		old = cur

		err := exec.Command("tmux", "set", "-g", "@status", out, ";", "refresh-client", "-S").Run()
		if err != nil && exec.Command("tmux", "show-options", "-gv", "status").Run() != nil {
			return
		}

		next := time.Now().Truncate(time.Second).Add(time.Second + 20*time.Millisecond)
		time.Sleep(time.Until(next))
	}
}

func main() {
	if len(os.Args) > 1 && os.Args[1] == "--daemon" {
		daemon()
		return
	}
	oneShot()
}
