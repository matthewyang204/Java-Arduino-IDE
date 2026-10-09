#!/usr/bin/env bash
set -eu

VERSION=$(sw_vers -productVersion)
if [[ "$(printf '%s\n' "$VERSION" "10.15" | sort -V | tail -n 1)" != "10.15" ]]; then
    echo "Skipping: macOS $VERSION is newer than 10.15."
    exit 0
fi

APP="$PWD/work/Arduino.app"
JDK=$(find "$APP/Contents" -type d -name '*.jdk' -print -quit)
if [ -z "$JDK" ]; then
    echo "ERROR: JDK bundle not found in $APP/Contents" >&2
    exit 1
fi
JDK="$JDK/Contents/Home"
if [ ! -d "$JDK" ]; then
    echo "ERROR: JDK home not found: $JDK" >&2
    exit 1
fi

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
