#!/bin/bash

mkdir built
gem install jekyll
jekyll build --destination built
