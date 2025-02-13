#!/usr/bin/env bash
#
# rewrite_m3u_paths.sh
# Replaces old file paths with new local file paths in M3U files,
# preserving TOP_OF_HOUR lines (i.e., we do NOT remove them).

# 1) Move to this script's directory
cd "$(dirname "$0")"

# 2) Move up to project root, where .env is located
cd ..

# 3) Load .env if present
if [ -f .env ]; then
  source .env
else
  echo "Warning: .env not found in project root. Using defaults."
fi

# 4) Define the M3U directory + old/new paths
M3U_DIR="${LOCAL_DIR:-/home/buck0five/playlists}"
OLD_PATH="/home/doitbestradio/content"
NEW_PATH="/home/buck0five/audiofiles"

echo "Rewriting M3U file paths in $M3U_DIR ..."

# 5) For each .m3u in $M3U_DIR
for m3u in "$M3U_DIR"/*.m3u; do
  [ -f "$m3u" ] || continue  # skip if no .m3u

  echo "Updating $m3u ..."
  # Replace OLD_PATH with NEW_PATH
  sed -i "s|$OLD_PATH|$NEW_PATH|g" "$m3u"
done

echo "M3U path rewrite completed at $(date)"
