#!/bin/bash

mkdir built
gem install jekyll

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then

sed "s/PRNO/$TRAVIS_PULL_REQUEST/g" _config.pull.yml > _config.yml
cat _config.yml
JEKYLL_ENV=production jekyll build --destination built --config _config.yml

cd built && tar -zcvf ../package.tar.gz . && cd -
curl -H "PR: $TRAVIS_PULL_REQUEST" --upload-file package.tar.gz -X POST https://temp-iitb.radialapps.com/webhook/

else

JEKYLL_ENV=production jekyll build --destination built --config _config.gh-pages.yml

fi
