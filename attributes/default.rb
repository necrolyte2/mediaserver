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

default['mediaserver']['sources']['video_sources'] = {}
