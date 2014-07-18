#!/bin/bash

set -ex

cd `dirname $0`; cd ../

if ! type chef-solo >/dev/null 2>&1; then
	curl -L https://www.opscode.com/chef/install.sh | bash	
fi
BASE="/opt/chef/embedded/bin"
PATH=${PWD}/.bundle/bin:${BASE}:${PATH}
bundle install --path ./.bundle/gems --binstubs ./.bundle/bin
rbenv rehash
berks vendor ./cookbooks
./config_solo.sh