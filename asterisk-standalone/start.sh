#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ ! -f .env ]]; then
  echo "Error: copy .env.example to .env and fill EXTERNAL_IP, SIP_PASSWORD_1, SIP_PASSWORD_2"
  exit 1
fi

exec docker compose --env-file .env up -d --build
