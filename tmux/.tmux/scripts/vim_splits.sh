#!/usr/bin/env bash

case "$1" in
  v)
    tmux split-window -h -c "#{pane_current_path}"
    ;;
  s)
    tmux split-window -v -c "#{pane_current_path}"
    ;;
  n)
    tmux new-window -c "#{pane_current_path}"
    ;;
  c)
    tmux kill-pane
    ;;
esac

