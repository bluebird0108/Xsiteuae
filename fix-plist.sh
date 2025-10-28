#!/bin/bash
# 🛠 fix-plist.sh — ensure correct Info.plist path for Xsiteuae

PROJECT_FILE="Xsiteuae.xcodeproj/project.pbxproj"
CORRECT_PATH="Xsiteuae/Xsiteuae/Info.plist"

echo "🔍 Checking Info.plist path..."
CURRENT_PATH=$(grep -m1 "INFOPLIST_FILE" "$PROJECT_FILE" | sed 's/.*= //; s/;//')

if [[ "$CURRENT_PATH" != "$CORRECT_PATH" ]]; then
  echo "⚠️  Wrong path detected: $CURRENT_PATH"
  echo "🧩 Fixing to: $CORRECT_PATH"
  sed -i '' "s|$CURRENT_PATH|$CORRECT_PATH|g" "$PROJECT_FILE"
  echo "✅ Info.plist path fixed."
else
  echo "✅ Info.plist path already correct."
fi

