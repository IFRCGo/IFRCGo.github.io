#!/usr/bin/env bash
set -e # halt script on error

# If this is the deploy branch, push it up to gh-pages
if [ $TRAVIS_PULL_REQUEST = "false" ] && [ $TRAVIS_BRANCH = ${DEPLOY_BRANCH} ]; then
  echo "Get ready, we're pushing to gh-pages!"
  cd _site
  git init
  git config user.name "Travis-CI"
  git config user.email "travis@somewhere.com"
  git add .
  git commit -m 'Build successful, build $TRAVIS_BUILD_NUMBER'
  echo "publishing to ${GH_REF} on ${TARGET_BRANCH}"
  git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" ${TARGET_BRANCH} > /dev/null 2>&1
else
  echo "Not a publishable branch so we're all done here"
fi
