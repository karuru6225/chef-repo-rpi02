include_recipe "iptables::common"

settings = Chef::EncryptedDataBagItem.load('network', 'settings')
template '/etc/iptables/iptables' do
  source 'iptables_router.sh.erb'
  owner 'root'
  group 'root'
  mode 00744
  variables(
    forwards: settings['forwards'],
    drop_countries: %w{CN KR TW HK KP}
  )
  notifies :restart, 'service[iptables]', :delayed
end

package 'linux-igd' do
  action :install
end

template '/etc/default/linux-igd' do
  source 'linux-igd.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[linux-igd]', :delayed
end

service 'linux-igd' do
  action :enable
end

