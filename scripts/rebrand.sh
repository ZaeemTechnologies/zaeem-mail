#!/usr/bin/env bash
# Minimal ZAEEM rebrand applied on top of the pinned upstream checkout. Usage: rebrand.sh <upstream-dir>
set -euo pipefail
d="${1:?upstream dir}"
f="$d/app-k9mail/build.gradle.kts"
sed -i 's/applicationId = "com.fsck.k9"/applicationId = "org.zaeemtechnologies.mail"/' "$f"
sed -i 's/testApplicationId = "com.fsck.k9.tests"/testApplicationId = "org.zaeemtechnologies.mail.tests"/' "$f"
sed -i 's/CLIENT_INFO_APP_NAME", "\\"K-9 Mail\\""/CLIENT_INFO_APP_NAME", "\\"ZAEEM Mail\\""/' "$f"
s="$d/app-k9mail/src/main/res/values/strings.xml"
[ -f "$s" ] && sed -i 's#<string name="app_name">[^<]*</string>#<string name="app_name">ZAEEM Mail</string>#' "$s"
grep -q 'org.zaeemtechnologies.mail"' "$f" || { echo "rebrand failed: applicationId not changed" >&2; exit 1; }
echo "rebrand applied"
