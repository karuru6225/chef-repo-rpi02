#
# Cookbook Name:: ddns
# Recipe:: default
#
# Copyright 1970, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

settings = Chef::EncryptedDataBagItem.load('network', 'settings')
cron 'ddns_register_ip_address' do
  minute '29'
  command "/usr/bin/curl -L -u #{settings['ddns_user']}:#{settings['ddns_pass']} #{settings['ddns_url']} > /dev/null 2>&1"
end
