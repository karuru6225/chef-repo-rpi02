#!/bin/bash

#以下のコマンドで実行する
#ワンライナー
#curl -kL https://raw.github.com/karuru6225/chef-repo-skeleton/master/scripts/setup.sh | bash && git clone https://github.com/karuru6225/chef-repo-skeleton.git && cd chef-repo && ./scripts/prepare.sh && ./scripts/run_chef-solo.sh

set -e

if [ -f /etc/redhat-release ]; then
	UNAME=`cat /etc/redhat-release`
	if [[ "${UNAME}" =~ .*CentOS.* ]];then
		OS="centos"
	fi
elif [ -f /etc/debian_version ]; then
	OS="debian"
else
	echo "unsupported OS"
	exit 1
fi

set -ex

if [ "${OS}" == "centos" ]; then
	yum -y install git gcc gcc-c++ automake autoconf make openssl-devel.x86_64
elif [ "${OS}" == "debian" ]; then
	apt-get -y install git build-essential libssl-dev libreadline5-dev
fi

cd /usr/local/
rm -rf rbenv
git clone git://github.com/sstephenson/rbenv.git rbenv

cat > /etc/profile.d/rbenv.sh << EOT
#!/bin/bash

export RBENV_ROOT=/usr/local/rbenv
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOT

chmod u+x /etc/profile.d/rbenv.sh

export RBENV_ROOT=/usr/local/rbenv
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"

if [ "`grep rbadmin /etc/group`" == "" ]; then
	/usr/sbin/groupadd rbadmin
fi
chgrp -R rbadmin rbenv
chmod -R g+rwxXs rbenv

mkdir /usr/local/rbenv/plugins
cd /usr/local/rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git
chgrp -R rbadmin ruby-build
chmod -R g+rwxs ruby-build

git clone https://github.com/ianheggie/rbenv-binstubs.git 
chgrp -R rbadmin rbenv-binstubs
chmod -R g+rwxs rbenv-binstubs

VERSION=`rbenv install -l | awk '{ print $1 }' | grep ^2 | grep -v '\(-rc\|-dev\|preview\)' | tail -n 1`
rbenv install ${VERSION}
rbenv global ${VERSION}
gem install bundler --no-rdoc --no-ri

