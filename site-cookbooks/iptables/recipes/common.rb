
directory '/etc/iptables/' do
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/etc/init.d/iptables' do
end
