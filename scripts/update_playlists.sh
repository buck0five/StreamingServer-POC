#!/usr/bin/env bash

cd "$(dirname "$0")"/..

# load env
if [ -f .env ]; then
  source .env
else
  echo "Error: .env file not found in $(pwd)"
  exit 1
fi

# Use env variables
lftp -u "$FTP_USER","$FTP_PASS" "ftp://$FTP_HOST" <<EOF
set ssl:verify-certificate no
mirror --verbose --include-glob *.m3u --parallel=1 $REMOTE_DIR $LOCAL_DIR
bye
EOF

echo "Playlists updated at $(date)"
