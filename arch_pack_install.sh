# Define the methods for install Arch Linux packages.

# AUR helper: trizen is unmaintained; prefer paru/yay if available.
AUR_HELPER="$(command -v paru || command -v yay || command -v trizen || echo trizen)"

pacman_install_noconfirm() {
  sudo pacman -S "$1" --noconfirm --needed
}

aur_install_noconfirm() {
  "$AUR_HELPER" -S "$1" --noconfirm --needed
}

echo_not_found() {
  echo -e "${COLOR_YELLOW}$1 is not installed, installing...${COLOR_NC}"
}

echo_is_existed() {
  echo -e "${COLOR_GREEN}$1 is already installed.${COLOR_NC}"
}

echo_install_failed() {
  echo -e "${COLOR_RED}Failed to install $1.${COLOR_NC}" >&2
}

# Check whether a package is installed in the local pacman database.
# AUR packages installed via any helper are also tracked here.
# Returns 0 if installed, 1 otherwise.
check_install() {
  if pacman -Qi "$1" >/dev/null 2>&1; then
    echo_is_existed "$1"
    return 0
  else
    echo_not_found "$1"
    return 1
  fi
}

# Install one package from official repos if not already installed.
pacman_install() {
  for package in "$@"; do
    if ! check_install "$package"; then
      if ! pacman_install_noconfirm "$package"; then
        echo_install_failed "$package"
        return 1
      fi
    fi
  done
}

# Install one package from AUR (or any repo the helper supports) if not installed.
aur_install() {
  for package in "$@"; do
    if ! check_install "$package"; then
      if ! aur_install_noconfirm "$package"; then
        echo_install_failed "$package"
        return 1
      fi
    fi
  done
}
