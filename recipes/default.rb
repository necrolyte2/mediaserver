include_recipe 'kodi'

package node['mediaserver']['apt-packages']

user node['mediaserver']['kodiuser']['username'] do
  home node['mediaserver']['kodiuser']['homedir']
  manage_home true
end

node['mediaserver']['kodiuser']['groups'].each do |agroup|
  group agroup do
    append true
    members node['mediaserver']['kodiuser']['username']
  end
end

cookbook_file '/etc/X11/Xwrapper.config' do
  source 'Xwrapper.config'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/init.d/kodi' do
  source 'kodi.initd.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    kodiuser: node['mediaserver']['kodiuser']['username']
  )
  notifies :restart, 'service[kodi]'
end

service 'kodi' do
  action [:enable]
end

template "#{node['mediaserver']['kodiuser']['homedir']}" \
  "/.kodi/userdata/sources.xml" do
  source 'sources.xml.erb'
  owner node['mediaserver']['kodiuser']['username']
  group node['mediaserver']['kodiuser']['username']
  mode '0640'
  variables(
    video_sources: node['mediaserver']['sources']['video_sources']
  )
end
