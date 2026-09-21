#!/usr/bin/env bash
set -euo pipefail

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter is required."
  exit 1
fi

if [[ ! -d android || ! -d ios ]]; then
  flutter create \
    --platforms=android,ios \
    --org com.tensio.health \
    --project-name tensio \
    .
fi

flutter pub get

echo "Tensio platform bootstrap complete."
echo "Next: flutter analyze && flutter test && flutter run"
