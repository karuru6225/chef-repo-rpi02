include_recipe "iptables::common"

settings = Chef::EncryptedDataBagItem.load('network', 'settings')
template '/etc/iptables/iptables.sh' do
  source 'iptables_router.sh.erb'
  owner 'root'
  group 'root'
  mode 00744
  variables(
    forwards: settings['forwards']
  )
end
