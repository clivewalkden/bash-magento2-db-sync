# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.8.0] - 2022-01-06
### Added
- Support for multiple PHP bin version on remote host
- Remote backup is deleted after retrieval to help detect any issues with the remote backup proceedure
- Started work on ini configuration for better option support
- Added sozo_imagify to the image directories ignored during image sync
- shini for future ini config usage
- Added localinstall for development testing

### Changed
- Updated tables to drop when stripping content


## [1.7.3] - 2021-09-21
### Changed
- Added the `--all-tables` flag to the WordPress database backup as some tables were missed without it


## [1.7.2] - 2021-08-03
### Changed
- Reverted full WordPress regex find-replace as the domain is used in the main site config not the full url


## [1.7.1] - 2021-07-30
### Changed
- Database dump no includes the --no-tablespaces option to stop PROCESS provilege error. (Requires n98-magerun >4.3.0).
- WordPress backup now runs search-replace on remote host export.
- Magento database import now uses n98-magerun to import database.
- WordPress import now uses wp-cli to import database.
- Tidy up of unneeded variables.


## [1.7.0] - 2021-04-27
### Added
- New flag to add prefix to sales orders, invoices, credit memos and shipments.
- Ability to change installed version when installing.

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