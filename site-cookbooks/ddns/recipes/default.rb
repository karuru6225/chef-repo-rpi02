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
  minute '26'
  command "/usr/bin/wget --http-user=#{settings['ddns_user']} --http-pass=#{settings['ddns_pass']} #{settings['ddns_url']}"
end
