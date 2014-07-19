#!/bin/bash

set -ex

cd `dirname $0`; cd ../

if ! type chef-solo >/dev/null 2>&1; then
	curl -L https://www.opscode.com/chef/install.sh | bash	
fi

bundle config build.nokogiri --use-system-libraries
bundle install --path ./.bundle/gems --binstubs ./.bundle/bin
rbenv rehash
berks install --path ./cookbooks
./config_solo.sh
