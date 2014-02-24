#!/bin/bash

set -ex

cd `dirname $0`; cd ../

if ! type chef-solo >/dev/null 2>&1; then
	curl -L https://www.opscode.com/chef/install.sh | bash	
fi
BASE="/opt/chef/embedded/bin"
PATH=${PWD}/.bundle/bin:${BASE}:${PATH}
bundle install --path ./.bundle/gems --binstubs ./.bundle/bin
berks install --path ./cookbooks
./config_solo.sh