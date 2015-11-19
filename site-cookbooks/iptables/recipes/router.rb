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
