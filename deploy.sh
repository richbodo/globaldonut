#!/usr/bin/env bash
# Deploy globaldonut.com to the apex on the globaldonut1 droplet.
# Site root + operator ownership are provisioned by the fellows_local_db
# Ansible caddy role (see ../fellows_local_db/ansible/roles/caddy).
set -euo pipefail

HOST="${GLOBALDONUT_HOST:-rsb@170.64.243.67}"
PORT="${GLOBALDONUT_PORT:-52221}"
DEST="${GLOBALDONUT_DEST:-/var/www/globaldonut/}"

cd "$(dirname "$0")"

rsync -avz --delete -e "ssh -p ${PORT}" \
  --exclude='.git/' --exclude='.gitignore' \
  --exclude='plans/'  --exclude='README.md' \
  --exclude='deploy.sh' \
  ./ "${HOST}:${DEST}"
