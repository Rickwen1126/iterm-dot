#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "$0")" && pwd)"
home_bin="$HOME/bin"
ssh_dir="$HOME/.ssh"
ssh_config="$ssh_dir/config"
dynamic_profiles_dir="$HOME/Library/Application Support/iTerm2/DynamicProfiles"

mkdir -p "$home_bin"
mkdir -p "$ssh_dir"
mkdir -p "$dynamic_profiles_dir"

install -m 755 "$repo_dir/bin/iterm-workmac-session" "$home_bin/iterm-workmac-session"
install -m 644 "$repo_dir/iTerm2/DynamicProfiles/workmac-profiles.json" "$dynamic_profiles_dir/workmac-profiles.json"

if [ ! -f "$ssh_config" ]; then
  touch "$ssh_config"
  chmod 600 "$ssh_config"
fi

if ! grep -q '^Host workmac$' "$ssh_config"; then
  {
    printf '\n'
    cat "$repo_dir/ssh/config.example"
    printf '\n'
  } >> "$ssh_config"
  echo "Added Host workmac block to $ssh_config"
else
  echo "Host workmac already exists in $ssh_config; left unchanged"
fi

cat <<EOF
Installed:
  $home_bin/iterm-workmac-session
  $dynamic_profiles_dir/workmac-profiles.json

Next:
  1. Edit $ssh_config if HostName/User differ
  2. Restart iTerm2
  3. Set iTerm2 tab title display to Profile Name
EOF
