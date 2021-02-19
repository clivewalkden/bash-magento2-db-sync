# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- New flag to add prefix to sales orders, invoices, credit memos and shipments.

### Changed
- Call to the site url changed and backup added.


## [1.6.0] - 2020-10-16
### Added
- Added ignore tables option for the main config which is passed to n98-magerun2.

### Changed
- Moved Magento commands over to individual file.
- Unified messaging throughout the app.


## [1.5.1] - 2020-10-14
### Fixed
- Incorrect version in the installer.


## [1.5.0] - 2020-10-14
### Added
- New fields for local file owner and group, and local shared directory
- Chown is now run for all transferred files.
- Theme files now regenerated.

### Changed
- Added check for www in domains when replacing urls
- Updated some of the messaging to be more uniform.


## [1.4.1] - 2020-09-08
### Changed
- Starting to unify messages.

### Fixed
- URL switch for WordPress database.


## [1.4.0] - 2020-09-02
### Added
- wordpress flag (disabled by default) to backup wordpress database and imagery.

### Changed
- Now using n98 to backup WordPress database to improve speed of system.


## [1.3.0] - 2020-07-29
### Added
- local-backup option (enabled by default)

### Changed
- Updated some variables to stop clashing with other scripts.


## [1.2.1] - 2020-07-10
### Changed
- Fixed message spacing issue.
- Added version number to the menu help option.
- Added reminder to be in a Magento 2 directory before trying to run the command.

### Fixed
- Installation link was pointing to old version.


## [1.2.0] - 2020-07-10
### Added
- Added menu option to allow full customer and order backups.


## [1.1.0] - 2020-07-10
### Added
- Installer
- Example [config file](./example.conf)
- [Changelog](./CHANGELOG.md)

### Changed
- README.md includes more information


## [1.0.0] - 2020-07-09
### Added
- Initial Release