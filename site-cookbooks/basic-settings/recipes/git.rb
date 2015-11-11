
package 'git'

cookbook_file '/etc/gitconfig' do
  source 'gitconfig'
  owner 'root'
  group 'root'
  mode 00644
end
