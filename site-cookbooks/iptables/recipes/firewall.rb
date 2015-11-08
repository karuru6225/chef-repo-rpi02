include_recipe "iptables::common"

settings = Chef::EncryptedDataBagItem.load('network', 'settings')
template '/etc/iptables/iptables' do
  source 'iptables_firewall.sh.erb'
  owner 'root'
  group 'root'
  mode 00744
  variables(
    ports: settings['ports']
  )
  notifies :restart, 'service[iptables]', :delayed
end
