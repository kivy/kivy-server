#!/bin/bash
set -e

# remove versions not in the repo anymore
for d in /web/doc/*/ ; do
  if [ -z "$(git ls-remote --heads https://github.com/kivy/kivy-website-docs.git "docs-$d")" ]; then
    rm -rf "$d"
  fi
done

cd /kivy-website-docs
git checkout main --quiet
git fetch origin --depth 1 --prune --quiet

# there's gonna be at least one version
versions=('"stable"' '"master"')

# update from repo
for full_name in $(git ls-remote --heads https://github.com/kivy/kivy-website-docs.git) ; do
  # only include docs-xxx branches
  if [[ $full_name != *"refs/heads/docs-"* || $full_name == *"refs/heads/docs-test-docs" ]] ; then
    continue
  fi

  name=$(sed -E "s~^refs/heads/docs-~~" <<< "$full_name")

  if [[ $name != "master" && $name != "stable" ]]; then
    versions+=("\"$name\"")
  fi

  if ! git show-ref --quiet refs/heads/docs-"$name"; then
    # branch doesn't exists, get it
    git checkout --track origin/docs-"$name"
  else
    if [[ $(git rev-parse "docs-$name") == $(git rev-parse "docs-$name@{u}") ]]; then
      # there has been no changes, nothing to do
      continue
    fi

    # update to remote
    git checkout docs-"$name"
    git reset --hard origin/docs-"$name"
  fi

  if [ -d /web/doc/"$name" ]; then
    mkdir /web/doc/"$name"
  fi;

  rsync --delete --force -r ./ /web/doc/"$name"/
done

echo '['"$(IFS=, ; echo "${versions[*]}")"']' > /web/doc/versions.json
