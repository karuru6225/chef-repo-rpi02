local_mode true

chef_repo_dir = File.absolute_path( File.dirname(__FILE__) + "/.." )

cookbook_path    ["#{chef_repo_dir}/cookbooks", "#{chef_repo_dir}/site-cookbooks"]
node_path        "#{chef_repo_dir}/nodes"
role_path        "#{chef_repo_dir}/roles"
environment_path "#{chef_repo_dir}/environments"
data_bag_path    "#{chef_repo_dir}/data_bags"
encrypted_data_bag_secret "#{chef_repo_dir}/data_bag_key"

knife[:berkshelf_path] = "#{chef_repo_dir}/cookbooks"
