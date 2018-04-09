#!/bin/bash

mkdir built
gem install jekyll

sed -i "s#COMMIT#P$CIRCLE_SHA1#g" _config.gh-pages.yml

JEKYLL_ENV=production jekyll build --destination built --config _config.gh-pages.yml

git config --global user.name "Xunk-Bot"
git config --global user.email "xunk@radialapps.com"
git config --global push.default matching
git clone git@github.com:pulsejet/wncc-all-deploy.git deploy

cd deploy
rm -r *
cp -R ../built/* ./
date > BUILD_TIME
git add -A
git commit -m "Automated Build"
git tag P$CIRCLE_SHA1
git push
git push origin P$CIRCLE_SHA1
cd ..
