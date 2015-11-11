
cookbook_file '/etc/rc.local' do
  source 'rc.local'
  owner 'root'
  group 'root'
  mode 00755
end

directory '/etc/rc.local.d' do
  owner 'root'
  group 'root'
  mode 00755
end
