require 'spec_helper'

describe 'mediaserver::kodi' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.automatic['lsb']['codename'] = 'Trusty'
    end.converge(described_recipe)
  end
  it 'includes kodi' do
    expect(chef_run).to include_recipe('kodi')
    expect(chef_run).to install_package('kodi')
  end
  it 'creates kodi user' do
    expect(chef_run).to create_user('kodi').with(manage_home: true)
    expect(chef_run).to create_group('cdrom').with(members: ['kodi'])
    expect(chef_run).to create_group('input').with(members: ['kodi'])
  end
  it 'configures Xwrapper' do
    expect(chef_run).to create_cookbook_file('/etc/X11/Xwrapper.config')
  end
  it 'creates kodi service' do
    expect(chef_run).to enable_service('kodi')
    expect(chef_run).to render_file('/etc/init.d/kodi')
  end
  it 'creates kodi sources xml' do
    expect(chef_run).to render_file(
      '/home/kodi/.kodi/userdata/sources.xml'
    )
  end
  it 'creates kodi advancedsettings xml' do
    expect(chef_run).to render_file(
      '/home/kodi/.kodi/userdata/advancedsettings.xml'
    )
  end
end
