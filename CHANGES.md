# Changelog

## Current

- Change main class to be `Travis::SaucelabsAPI::Connection`.
- Add `Travis::SaucelabsAPI::VirtualMachine` class which can be used to get
  information from the `instance_info` data.

## v0.0.2

- Add allow_incoming endpoint, which allows for opening incoming ports in the
  firewall (for example to SSH in from outside the LAN).
- Require API responses to use the application/json Content-Type to be parsed as
  JSON.

## v0.0.1

Initial release