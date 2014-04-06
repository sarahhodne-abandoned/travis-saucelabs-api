# Changelog

## v0.0.3

- Allow specifying an image when starting a VM with the CLI (using `--image`).
- Change the default image name to `ichef-travis-osx8-latest`.
- Raise errors on all 4xx and 5xx errors. They are raised as
  `Travis::SaucelabsAPI::ClientError` and `Travis::SaucelabsAPI::ServerError`,
  respectively, and both inherit from `Travis::SaucelabsAPI::Error`.

## v0.0.2

- Add allow_incoming endpoint, which allows for opening incoming ports in the
  firewall (for example to SSH in from outside the LAN).
- Require API responses to use the application/json Content-Type to be parsed as
  JSON.

## v0.0.1

Initial release
