#!/usr/bin/env bash

systemctl_enable() {
  # 未启用才 enable
  if [ "$(systemctl is-enabled $1 2>/dev/null || true)" != "enabled" ]; then
    echo -e "${COLOR_GREEN}enabling $1.${COLOR_NC}"
    sudo systemctl enable $1
  else
    echo -e "${COLOR_GREEN}$1 already enabled${COLOR_NC}"
  fi
}

systemctl_start() {
  # 未运行才 start
  if [ "$(systemctl is-active $1 2>/dev/null || true)" != "active" ]; then
    echo -e "${COLOR_GREEN}starting $1${COLOR_NC}"
    sudo systemctl start $1
  else
    echo -e "${COLOR_GREEN}$1 already running${COLOR_NC}"
  fi
}

systemctl_enable sshd.service
systemctl_start sshd.service
