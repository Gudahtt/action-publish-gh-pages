#!/usr/bin/env bash

set -x
set -e
set -o pipefail

DIRECTORY="${1}"
export PREFIX=${2}
export NEW_VERSION="${GITHUB_HEAD_REF#$PREFIX}"

if [[ -z $DIRECTORY ]]; then
  echo "Error: No Directory specified."
  exit 1
fi

git config user.name github-actions
git config user.email github-actions@github.com

cd $GITHUB_ACTION_PATH;
yarn setup
git worktree add $DIRECTORY gh-pages
yarn build
cd $DIRECTORY
git add --all
git commit -m "gh-pages deploy - ${NEW_VERSION}"
git push -f origin gh-pages