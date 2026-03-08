#!/bin/bash
# Helper script to create AnyGen task for Apple Podcasts

SHARE_LINK="$1"

if [ -z "$SHARE_LINK" ]; then
  echo "Usage: $0 <apple_podcasts_url>"
  exit 1
fi

if [ -z "$ANYGEN_API_KEY" ]; then
  echo "Error: ANYGEN_API_KEY environment variable is not set"
  exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Read the English prompt template
PROMPT=$(cat "$SCRIPT_DIR/prompt_template_en.txt")

# Replace the share link placeholder
PROMPT="${PROMPT//SHARE_LINK_PLACEHOLDER/$SHARE_LINK}"

# Create the task
curl -sS https://www.anygen.io/v1/openapi/tasks \
  -H 'Content-Type: application/json' \
  --data-binary @- << EOF
{
  "auth_token": "Bearer $ANYGEN_API_KEY",
  "operation": "website",
  "language": "en",
  "prompt": $(echo "$PROMPT" | jq -Rs .)
}
EOF
