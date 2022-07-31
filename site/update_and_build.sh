#!/bin/sh

echo "Starting update_and_build.sh"
FORCE_BUILD="${FORCE_BUILD:-0}"

cd /web/kivy-website

git fetch origin --depth 1 --prune --quiet

if [[ $(git rev-parse @{u}) != $(git rev-parse @) ]] || [[ $FORCE_BUILD == 1 ]] ; then
    echo "Detected changes, rebuilding ..."
    git reset --hard origin/feat/new-website
    python3 -m pip install -r requirements.txt
    npm ci
    npm run build
    python3 tools/build.py
    cp -r dist/* /web/site
else
    echo "No changes detected"
fi
