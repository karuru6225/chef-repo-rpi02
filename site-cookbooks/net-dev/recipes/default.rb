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

cookbook_file '/etc/network/interfaces' do
  source 'interfaces'
  owner 'root'
  group 'root'
  mode 00644
end
