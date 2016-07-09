include_recipe 'mediaserver::kodi'
include_recipe 'mediaserver::database' \
  if node['mediaserver']['database']['type'] == 'mysql'
