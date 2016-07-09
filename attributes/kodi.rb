default['mediaserver']['apt-packages'] = [
  'x11-common', 'xserver-xorg-input-all', 'xserver-xorg-video-intel',
  'xserver-common', 'xserver-xorg', 'x11-xserver-utils', 'xorg',
  'xserver-xorg-video-ati', 'xserver-xorg-video-radeon',
  'xserver-xorg-video-vesa', 'x11-utils', 'x11-xserver-utils'
]

default['mediaserver']['kodiuser']['username'] = 'kodi'
default['mediaserver']['kodiuser']['homedir'] = '/home/kodi'
default['mediaserver']['kodiuser']['groups'] = %w(
  cdrom audio video plugdev users dialout dip input
)

# Each video_sources item must be a hash of(example)
# {
#   'name' => 'Movies',
#   'path' => 'smb://localhost/Movies',
#   'allowsharing' => true|false # Optionally omit this key for false
# }
default['mediaserver']['sources']['video_sources'] = []
# Video and Music databse should be a hash of
# {
#   'type' => 'mysql',
#   'host' => 'localhost',
#   'port' => '3389',
#   'user' => 'kodi',
#   'pass' => 'kodi'
# }
default['mediaserver']['advancedsettings']['video_database'] = {}
default['mediaserver']['advancedsettings']['music_database'] = {}
