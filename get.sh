#!/usr/bin/env bash
set -Eeuo pipefail
umask 077
[[ $EUID == 0 ]] || { echo 'Use: curl -fsSL https://raw.githubusercontent.com/liusongnb/qqbot-oneclick/main/get.sh | sudo bash' >&2; exit 1; }
command -v curl >/dev/null || { echo 'Install curl first.' >&2; exit 1; }
command -v sha256sum >/dev/null || { echo 'sha256sum is required.' >&2; exit 1; }
work=$(mktemp -d /tmp/qqbot-share.XXXXXXXX)
trap 'rm -rf -- "$work"' EXIT
curl --fail --silent --show-error --location --proto '=https' --connect-timeout 20 --max-time 300 https://raw.githubusercontent.com/liusongnb/qqbot-oneclick/main/qqbot-share-1.12.0-share.1.tar.gz -o "$work/package.tar.gz"
printf 'eb4cb452c16ba217e672a74a0b1a97f991cb750ffb9af1a8a4ff803425a44b5a  %s\n' "$work/package.tar.gz" | sha256sum --check --status
tar -xzf "$work/package.tar.gz" -C "$work" --no-same-owner
bash "$work/qqbot-share/install.sh" "$@"
