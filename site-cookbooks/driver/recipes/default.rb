#
# Cookbook Name:: driver
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/lib/modules/3.18.0-20-rpi2/kernel/drivers/net/wireless/8812au.ko' do
  source '8812au.ko'
  owner 'root'
  group 'root'
  mode 00644
end

bash 'update module deps' do
  code <<-EOH
    /sbin/depmod -a 3.18.0-20-rpi2
    /sbin/modprobe 8812au
  EOH
  not_if 'lsmod | grep 8812au'
end
