#!/usr/bin/env bash
set -Eeuo pipefail
umask 077
[[ $EUID == 0 ]] || { echo 'Use: curl -fsSL https://raw.githubusercontent.com/liusongnb/qqbot-oneclick/main/get.sh | sudo bash' >&2; exit 1; }
command -v curl >/dev/null || { echo 'Install curl first.' >&2; exit 1; }
command -v sha256sum >/dev/null || { echo 'sha256sum is required.' >&2; exit 1; }
work=$(mktemp -d /tmp/qqbot-share.XXXXXXXX)
trap 'rm -rf -- "$work"' EXIT
curl --fail --silent --show-error --location --proto '=https' --connect-timeout 20 --max-time 300 https://raw.githubusercontent.com/liusongnb/qqbot-oneclick/main/qqbot-share-1.12.0-share.1.tar.gz -o "$work/package.tar.gz"
printf '146387e16922e79de6e1ebcad0933e76f01fb704e7e82d5597382a4635e3ffc7  %s\n' "$work/package.tar.gz" | sha256sum --check --status
tar -xzf "$work/package.tar.gz" -C "$work" --no-same-owner
bash "$work/qqbot-share/install.sh" "$@"
