require 'spec_helper'

describe 'mediaserver::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.automatic['lsb']['codename'] = 'Trusty'
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
      node.set['mediaserver']['advancedsettings']['videodatabase'] = {
        'type' => 'foo1',
        'host' => 'localhost1',
        'port' => '12341',
        'user' => 'bar1',
        'pass' => 'pass1'
      }
      node.set['mediaserver']['advancedsettings']['musicdatabase'] = {
        'type' => 'foo2',
        'host' => 'localhost2',
        'port' => '12342',
        'user' => 'bar2',
        'pass' => 'pass2'
      }
    end.converge(described_recipe)
  end
  it 'creates kodi sources xml' do
    expect(chef_run).to render_file(
      '/home/kodi/.kodi/userdata/sources.xml'
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
  it 'creates kodi advancedsettings xml' do
    expect(chef_run).to render_file(
      '/home/kodi/.kodi/userdata/advancedsettings.xml'
    ).with_content { |content|
      expect(content).to include('<type>foo1</type>')
      expect(content).to include('<host>localhost1</host>')
      expect(content).to include('<port>12341</port>')
      expect(content).to include('<user>bar1</user>')
      expect(content).to include('<pass>pass1</pass>')
      expect(content).to include('<type>foo2</type>')
      expect(content).to include('<host>localhost2</host>')
      expect(content).to include('<port>12342</port>')
      expect(content).to include('<user>bar2</user>')
      expect(content).to include('<pass>pass2</pass>')
    }
  end
  it 'not include database' do
    expect(chef_run).not_to include_recipe('mediaserver::database')
  end
  context 'mysql database' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['lsb']['codename'] = 'Trusty'
        node.set['mediaserver']['database']['type'] = 'mysql'
      end.converge(described_recipe)
    end
    it 'includes database recipe if type is mysql' do
      expect(chef_run).to include_recipe('mediaserver::database')
    end
  end
end
