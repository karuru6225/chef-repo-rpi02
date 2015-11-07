#
# Cookbook Name:: dnsmasq
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'dnsmasq' do
  action :install
end

service 'dnsmasq' do
  action [:enable]
end

settings = Chef::EncryptedDataBagItem.load('network', 'settings')
template '/etc/hosts' do
  source 'hosts.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    domain: settings['domain'],
    network: settings['network'],
    hosts: settings['hosts']
  )
  notifies :restart, 'service[dnsmasq]', :delayed
end

template '/etc/dnsmasq.conf' do
  source 'dnsmasq.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    domain: settings['domain'],
    network: settings['network'],
    router: settings['router'],
    netmask: settings['netmask'],
    range_start: settings['range_start'],
    range_end: settings['range_end'],
    hosts: settings['hosts']
  )
  notifies :restart, 'service[dnsmasq]', :delayed
end
