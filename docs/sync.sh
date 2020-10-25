#!/bin/bash
set -e

DOCS_ROOT=/web/doc

# remove versions not in the repo anymore
pushd "$DOCS_ROOT" > /dev/null
for d in */ ; do
  # remove forward slash
  d=${d::-1}
  if [ -z "$(git ls-remote --heads https://github.com/kivy/kivy-website-docs.git "docs-$d")" ]; then
    rm -rf "$d"
  fi
done
popd > /dev/null

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
    git checkout --track origin/docs-"$name" --quiet
  else
    if [[ $(git rev-parse "docs-$name") == $(git rev-parse "docs-$name@{u}") ]]; then
      # there has been no changes, nothing to do
      continue
    fi

    # update to remote
    git checkout docs-"$name" --quiet
    git reset --hard origin/docs-"$name" --quiet
  fi

  if [ ! -d "$DOCS_ROOT/$name" ]; then
    mkdir "$DOCS_ROOT/$name"
  fi;

  rsync --delete --force --exclude .git/ --exclude .gitignore -r ./ "$DOCS_ROOT/$name/"
done

echo '['"$(IFS=, ; echo "${versions[*]}")"']' > "$DOCS_ROOT/versions.json"
