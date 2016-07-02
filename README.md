# mediaserver

[![Build Status](https://travis-ci.org/necrolyte2/mediaserver.svg?branch=master)](https://travis-ci.org/necrolyte2/mediaserver)

Chef cookbook to setup a home media server based on kodi

# Running the cookbook

The instructions assume you are running Ubuntu as your OS

1. First install the chef client

   `sudo curl -s http://www.getchef.com/chef/install.sh | /bin/bash`
1. Make sure you have system dependencies installed

   `sudo apt-get update && sudo apt-get install -y git`

1. Then clone this repository

   `git clone https://github.com/necrolyte2/mediaserver.git`
1. Enter the cookbook directory

   `cd mediaserver`
1. Ensure PATH is setup correctly

   `export PATH=/opt/chef/embedded/bin:$PATH`
1. Install required gems

   `bundle install --path vendor/plugins`
1. Install dependency cookbooks

   `bundle exec berks vendor /tmp/cookbooks`
1. Run chef client to setup mediaserver

   `cd /tmp && chef-client -z -o mediaserver`
