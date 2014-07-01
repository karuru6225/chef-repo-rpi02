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

cat <<'EOF' > Berksfile
site :opscode
cookbook 'cookbook-ruby', git: 'https://github.com/kiyohiro-kano/cookbook-ruby.git'
EOF

BASEDIR=`pwd`
[ -d /tmp/chef-solo ] || mkdir -p /tmp/chef-solo

cat <<'EOF' > solo.rb
file_cache_path "/tmp/chef-solo"
cookbook_path ".cookbooks"
ssl_verify_mode :verify_peer
EOF

cat <<'EOF' > conf.json
{
        "run_list" : [
                "recipe[cookbook-ruby]"
        ]
}
EOF

PATH=${PATH}:/opt/chef/embedded/bin/

bundle install --path vendor/bundle
bundle exec berks vendor ./cookbooks
chef-solo -c solo.rb -j conf.json


