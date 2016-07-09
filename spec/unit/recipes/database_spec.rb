require 'spec_helper'

describe 'mediaserver::database' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['mediaserver']['database']['instance']['name'] = 'foo_service'
      node.set['mediaserver']['database']['instance']['port'] = '3306'
      node.set['mediaserver']['database']['instance']['version'] = '5.5'
      node.set['mediaserver']['database']['instance']['root_username'] = 'root'
      node.set['mediaserver']['database']['instance']['root_password'] = 'root1'
      node.set['mediaserver']['database']['instance']['host'] = '127.0.0.1'
      node.set['mediaserver']['database']['instance']['admin_username'] = \
        'admin'
      node.set['mediaserver']['database']['instance']['admin_password'] = \
        'admin1'
    end.converge(described_recipe)
  end
  it 'creates mysql instance' do
    expect(chef_run).to create_mysql_service('foo_service').with(
      port: '3306',
      version: '5.5',
      initial_root_password: 'root1'
    )
  end
  it 'creates admin user' do
    expect(chef_run).to create_mysql_database_user('admin').with(
      password: 'admin1',
      privileges: [:all]
    )
  end
end
