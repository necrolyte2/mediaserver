mysql2_chef_gem 'default' do
  action :install
end

mysql_service node['mediaserver']['database']['instance']['name'] do
  port node['mediaserver']['database']['instance']['port']
  version node['mediaserver']['database']['instance']['version']
  initial_root_password \
    node['mediaserver']['database']['instance']['root_password']
  action [:create, :start]
end

mysql_database_user \
  node['mediaserver']['database']['instance']['admin_username'] do
  connection(
    host: node['mediaserver']['database']['instance']['host'],
    username: node['mediaserver']['database']['instance']['root_username'],
    password: node['mediaserver']['database']['instance']['root_password']
  )
  password node['mediaserver']['database']['instance']['admin_password']
  host '%'
  privileges [:all]
  action [:create, :grant]
end
