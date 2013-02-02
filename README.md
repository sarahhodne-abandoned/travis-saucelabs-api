# Travis::SaucelabsAPI

This is an API wrapper to the Travis<->Saucelabs API for Mac VMs

## Installation

Add this line to your application's Gemfile:

    gem 'travis-saucelabs-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install travis-saucelabs-api

## Usage

``` ruby
require 'travis-saucelabs-api'

api = Travis::SaucelabsAPI.new('http://user:password@api.example.com:1234')

# The available capacity for the cloud
#
# ichef is the VM type
api.capacity # => { 'ichef' => 10 }

# Start up a VM instance
api.start_instance # => { 'instance_id' => '38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1' }

# Get a list of the running instances
api.list_instances # => { 'instances' => [ '38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1' ]}

# Get information about an instance
api.instance_info('38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1') # => {
#   'public_ip' => '10.10.10.10',
#   'vnc_port' => '5900',
#   'FQDN' => 'vm1.example.com',
#   'time_created' => 1355294100.609689,
#   'instance_id' => '38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1',
#   'image_id' => 'ichef-osx8-10.8-working',
#   'State' => 'Running',
#   'private_ip' => '10.10.20.10',
#   'real_image_id' => 'ichef-osx8-10.8-working',
# }

# Stop a VM instance (like unplugging its power)
api.kill_instance('38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1')

# Open the firewall for a given VM instance to allow outgoing connections
# (firewalled off by default, watch out.)
api.open_outgoing('38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1')

# Save a disk image from a running VM. Use this sparingly.
api.save_image('38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
