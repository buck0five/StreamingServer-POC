#!/usr/bin/env bash

# Move into this script's directory so .env is found
cd "$(dirname "$0")"/..

# Load .env
if [ -f .env ]; then
  source .env
else
  echo "Error: .env not found!"
  exit 1
fi

# Check required variables
if [ -z "$S3_ENDPOINT" ] || [ -z "$S3_ACCESS_KEY_ID" ] || [ -z "$S3_SECRET_ACCESS_KEY" ] || [ -z "$S3_BUCKET_NAME" ] || [ -z "$S3_LOCAL_DIR" ]; then
  echo "Error: One or more S3 environment variables missing!"
  exit 1
fi

# Create local dir if it doesn't exist
mkdir -p "$S3_LOCAL_DIR"

# Configure rclone remote named "linode-s3" on the fly
rclone config create linode-s3 s3 \
    provider "Other" \
    env_auth=false \
    access_key_id="$S3_ACCESS_KEY_ID" \
    secret_access_key="$S3_SECRET_ACCESS_KEY" \
    region "us-southeast-1" \
    endpoint="$S3_ENDPOINT" \
    acl="private" \
    --non-interactive

# Sync from bucket to local
# If you want to mirror EXACTLY, use rclone sync
# If you don't want local files deleted, use rclone copy
rclone sync linode-s3:"$S3_BUCKET_NAME" "$S3_LOCAL_DIR" --verbose

echo "S3 sync completed at $(date)"
