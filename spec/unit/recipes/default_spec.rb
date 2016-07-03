require 'spec_helper'

describe 'mediaserver::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.automatic['lsb']['codename'] = 'Trusty'
      node.set['mediaserver']['kodiuser']['groups'] = %w(foo bar)
      node.set['mediaserver']['kodiuser']['username'] = 'foobar'
      node.set['mediaserver']['kodiuser']['homedir'] = '/home/foobar'
      node.set['mediaserver']['sources']['video_sources'] = [
        {
          'name' => 'source1',
          'path' => 'smb://127.0.0.1/foo',
          'allowsharing' => true
        },
        {
          'name' => 'source2',
          'path' => 'smb://127.0.0.1/bar'
        }
      ]
    end.converge(described_recipe)
  end
  it 'includes kodi' do
    expect(chef_run).to include_recipe('kodi')
    expect(chef_run).to install_package('kodi')
  end
  it 'creates kodi user' do
    expect(chef_run).to create_user('foobar').with(manage_home: true)
    expect(chef_run).to create_group('foo').with(members: ['foobar'])
    expect(chef_run).to create_group('bar').with(members: ['foobar'])
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
      '/home/foobar/.kodi/userdata/sources.xml'
    ).with_content { |content|
      expect(content).to include('<name>source1</name>')
      expect(content).to include(
        '<path pathversion="1">smb://127.0.0.1/foo</path>'
      )
      expect(content).to include('<allowsharing>true</allowsharing>')
      expect(content).to include('<name>source2</name>')
      expect(content).to include(
        '<path pathversion="1">smb://127.0.0.1/bar</path>'
      )
      expect(content).to include('<allowsharing>false</allowsharing>')
    }
  end
end
