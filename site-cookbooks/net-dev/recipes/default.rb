#
# Cookbook Name:: net-dev
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'bridge-utils' do
  action :install
end

settings = Chef::EncryptedDataBagItem.load('network', 'settings')
template '/etc/network/interfaces' do
  source 'interfaces.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    network: settings['network'],
    router: settings['router'],
    netmask: settings['netmask'],
    broadcast: settings['broadcast']
  )
end

cookbook_file '/etc/init/failsafe.conf' do
  source 'failsafe.conf'
  owner 'root'
  group 'root'
  mode 00644
end
