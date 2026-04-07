#!/bin/sh
set -e

echo "=== ENTRYPOINT START ==="

# Проверка envsubst
if ! command -v envsubst >/dev/null 2>&1; then
  echo "envsubst not found, installing..."

  if command -v apk >/dev/null 2>&1; then
    apk add --no-cache gettext
  elif command -v apt-get >/dev/null 2>&1; then
    apt-get update && apt-get install -y gettext-base
  else
    echo "ERROR: no package manager found"
    exit 1
  fi
fi

# Генерация конфига
if [ -n "$TEMPLATE_FILE" ] && [ -n "$OUTPUT_FILE" ]; then
  echo "Generating config from template:"
  echo "Template: $TEMPLATE_FILE"
  echo "Output: $OUTPUT_FILE"

  envsubst < "$TEMPLATE_FILE" > "$OUTPUT_FILE"

  echo "=== GENERATED CONFIG ==="
  cat "$OUTPUT_FILE"
  echo "========================"
fi

echo "Starting main process..."
exec "$@"