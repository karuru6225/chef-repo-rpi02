#
# Cookbook Name:: hostapd
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'hostapd' do
  action :install
end

service 'hostapd' do
  action [:enable]
end

settings = Chef::EncryptedDataBagItem.load('hostapd', 'settings')
template '/etc/hostapd/hostapd_2.4ghz.conf' do
  source 'hostapd_2.4ghz.conf.erb'
  owner 'root'
  group 'root'
  mode 00600
  variables(
    ssid: settings['ssid']+'-g',
    pass: settings['pass']
  )
  notifies :restart, 'service[hostapd]', :delayed
end

template '/etc/hostapd/hostapd_5ghz.conf' do
  source 'hostapd_5ghz.conf.erb'
  owner 'root'
  group 'root'
  mode 00600
  variables(
    ssid: settings['ssid']+'-a',
    pass: settings['pass']
  )
  notifies :restart, 'service[hostapd]', :delayed
end

cookbook_file '/etc/default/hostapd' do
  source 'hostapd'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[hostapd]', :delayed
end
