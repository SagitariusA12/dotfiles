#!/bin/bash
# ──────────────────────────────────────────────
#  setup-iwd.sh — Configura iwd como backend do NetworkManager
#  Autor: gerado para Sagittarius
# ──────────────────────────────────────────────

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info()    { echo -e "${CYAN}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }
error()   { echo -e "${RED}[ERRO]${NC} $1"; exit 1; }

echo -e "${CYAN}"
echo "╔══════════════════════════════════════╗"
echo "║      Setup iwd + NetworkManager      ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

# ── 1. Verificar root ────────────────────────
if [[ $EUID -ne 0 ]]; then
    error "Execute como root: sudo bash setup-iwd.sh"
fi

# ── 2. Instalar dependências ─────────────────
info "Instalando iwd..."
pacman -S --noconfirm iwd || error "Falha ao instalar iwd"
success "iwd instalado"

info "Instalando iwgtk via yay..."
if command -v yay &>/dev/null; then
    sudo -u "${SUDO_USER}" yay -S --noconfirm iwgtk || warn "iwgtk não instalado (AUR)"
    success "iwgtk instalado"
else
    warn "yay não encontrado, pulando iwgtk"
fi

# ── 3. Config do iwd ─────────────────────────
info "Criando /etc/iwd/main.conf..."
mkdir -p /etc/iwd
cat > /etc/iwd/main.conf << 'EOF'
[General]
EnableNetworkConfiguration=false

[Network]
EnableIPv6=true
NameResolvingService=systemd
EOF
success "/etc/iwd/main.conf criado"

# ── 4. Config do NetworkManager ──────────────
info "Configurando NetworkManager para usar iwd..."
cat > /etc/NetworkManager/NetworkManager.conf << 'EOF'
# Configuration file for NetworkManager.
# See "man 5 NetworkManager.conf" for details.
[main]
dhcp=internal

[device]
wifi.backend=iwd
EOF
success "Backend iwd configurado em NetworkManager.conf"

# ── 5. Serviços ──────────────────────────────
info "Habilitando e iniciando iwd..."
systemctl enable iwd
systemctl start iwd
success "iwd ativo"

info "Reiniciando NetworkManager..."
systemctl restart NetworkManager
success "NetworkManager reiniciado"

# ── 6. Verificação final ─────────────────────
echo ""
info "Status dos serviços:"
systemctl is-active iwd && success "iwd: rodando" || warn "iwd: inativo"
systemctl is-active NetworkManager && success "NetworkManager: rodando" || warn "NetworkManager: inativo"

echo ""
info "Dispositivos de rede:"
nmcli device status

echo ""
success "Configuração concluída!"
echo -e "${YELLOW}Dica: conecte via 'nmcli device wifi connect \"SSID\" password \"SENHA\"'${NC}"
