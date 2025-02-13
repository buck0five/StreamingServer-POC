#!/usr/bin/env bash
#
# update_playlists.sh
# Downloads .m3u files from FTP to a local directory, then rewrites
# file paths in those M3U files.

# 1) Move to this script's directory (i.e., 'scripts/')
cd "$(dirname "$0")"

# 2) Move up to project root, where .env is located
cd ..

# 3) Load the .env file if present
if [ -f .env ]; then
  source .env
else
  echo "Error: .env not found in project root!"
  exit 1
fi

# 4) Define defaults if .env doesn't specify them:
FTP_HOST="${FTP_HOST:-ftp.example.com}"
FTP_USER="${FTP_USER:-anonymous}"
FTP_PASS="${FTP_PASS:-anonymous}"
REMOTE_DIR="${REMOTE_DIR:-/path/on/ftp}"    # Directory on FTP containing .m3u
LOCAL_DIR="${LOCAL_DIR:-/home/buck0five/playlists}"  # Where .m3u are stored locally

echo "Downloading .m3u files from $FTP_HOST..."

# 5) Use lftp to mirror .m3u files
lftp -u "$FTP_USER","$FTP_PASS" "ftp://$FTP_HOST" <<EOF
set ssl:verify-certificate no
mirror --verbose --include-glob *.m3u --parallel=1 $REMOTE_DIR $LOCAL_DIR
bye
EOF

echo "Playlists updated at $(date)"

# 6) Rewrite paths in the M3U files
cd scripts
./rewrite_m3u_paths.sh
