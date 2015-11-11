
include_recipe "basic-settings::rc-local"

template '/etc/rc.local.d/ntpdate.sh' do
  source 'ntpdate.sh.erb'
  owner 'root'
  group 'root'
  mode 00744
  variables(
    url: node['basic-settings']['ntpdate']['url']
  )
end

cron 'ntpdate_update' do
  minute '36'
  hour '10'
  command "/usr/sbin/ntpdate #{node['basic-settings']['ntpdate']['url']}"
end

