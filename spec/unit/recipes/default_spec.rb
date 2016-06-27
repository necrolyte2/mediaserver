require 'spec_helper'

describe 'mediaserver::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
			node.automatic['lsb']['codename'] = 'Trusty'
			node.set['mediaserver']['kodiuser']['groups'] = ['foo', 'bar']
			node.set['mediaserver']['kodiuser']['username'] = 'foobar'
    end.converge(described_recipe)
  end

	it 'includes kodi' do
    expect(chef_run).to include_recipe('kodi')
		expect(chef_run).to install_package('kodi')
	end

	it 'creates kodi user' do
		expect(chef_run).to create_user('foobar').with(:manage_home => true)
		expect(chef_run).to create_group('foo').with(:members => ['foobar'])
		expect(chef_run).to create_group('bar').with(:members => ['foobar'])
	end

	it 'configures Xwrapper' do
		expect(chef_run).to create_cookbook_file('/etc/X11/Xwrapper.config')
	end

	it 'creates kodi service' do
		expect(chef_run).to enable_service('kodi')
		expect(chef_run).to render_file('/etc/init.d/kodi')
	end

end
