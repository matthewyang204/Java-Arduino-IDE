#!/usr/bin/env bash
set -eu

APP="$PWD/work/Arduino.app"
JDK="$APP"/Contents/PlugIns/*.jdk/Contents/Home

OLD="/System/Library/Frameworks/JavaRuntimeSupport.framework/Versions/A/JavaRuntimeSupport"
NEW="/System/Library/Frameworks/JavaVM.framework/Versions/A/Frameworks/JavaRuntimeSupport.framework/Versions/A/JavaRuntimeSupport"

if [ ! -f "$NEW" ]; then
    echo "ERROR: <=Catalina framework binary not found: $NEW" >&2
    exit 1
fi

count=0

while IFS= read -r -d '' file; do
    if otool -L "$file" 2>/dev/null | grep -Fq "$OLD"; then
        echo "Patching: $file"

        cp -p "$file" "$file.bak"
        install_name_tool -change "$OLD" "$NEW" "$file"

        count=$((count + 1))
    fi
done < <(find "$JDK" -type f -name '*.dylib' -print0)

echo "Patched $count dylib(s)."
