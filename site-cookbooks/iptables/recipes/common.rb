
directory '/etc/iptables/' do
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/etc/init.d/iptables' do
  source 'iptables.service'
  owner 'root'
  group 'root'
  mode 00755
  notifies :restart, 'service[iptables]', :delayed
end

service 'iptables' do
  action :enable
end
