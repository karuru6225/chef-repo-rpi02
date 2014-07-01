#!/bin/bash

#以下のコマンドで実行する
#ワンライナー
#curl -kL https://raw.github.com/kiyohiro-kano/chef-repo-skeleton/master/scripts/setup.sh | bash && git clone https://github.com/kiyohiro-kano/chef-repo-skeleton.git && cd chef-repo && ./scripts/prepare.sh && ./scripts/run_chef-solo.sh

set -ex

if [ -f /etc/redhat-release ]; then
	yum -y install git gcc gcc-c++ automake autoconf make openssl-devel.x86_64
elif [ -f /etc/debian_version ]; then
	apt-get -y install git build-essential libssl-dev libreadline5-dev
else
	echo "unsupported OS"
	exit 1
fi

if ! type chef-solo >/dev/null 2>&1; then
	curl -L https://www.opscode.com/chef/install.sh | bash  
fi

cat <<'EOF' > Gemfile
source 'https://rubygems.org'
gem 'berkshelf'
EOF

/opt/chef/embedded/bin/bundle install --path vendor/bundle

#/opt/chef/embedded/bin/gem
