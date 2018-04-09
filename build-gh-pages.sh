#!/bin/bash

mkdir built
gem install jekyll
JEKYLL_ENV=production jekyll build --destination built --config _config.gh-pages.yml

if [ "$TRAVIS_PULL_REQUEST" != "master" ]; then

cd built && tar -zcvf ../package.tar.gz . && cd -
curl -H "PR: $TRAVIS_PULL_REQUEST" --upload-file package.tar.gz -X POST https://temp-iitb.radialapps.com/webhook/

fi
