# Puppet module to manage InfluxDB Server

[![Build status][travis-image]][travis-url]

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with InfluxDB](#setup)
    * [What InfluxDB affects](#what-InfluxDB-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with InfluxDB](#beginning-with-InfluxDB)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Installs, configures and manages the the [InfluxDB](https://github.com/influxdata/influxdb)
time-series platform.

## Setup

### What InfluxDB affects

Default configuration

-   manages GPG key, repository
        (use `$manage_repo` to deactivate when another influxdata module takes the lead)

-   manages package

-   manages user and group influxdb

-   manages directories and configuration files (referring to templates)
    -   `/etc/influxdb/influxdb.conf`
    -   `/etc/default/influxdb`
    -   `/lib/systemd/system/influxdb.service`

-   starts service "influxdb" immediately

### Setup Requirements

-   `puppetlabs/apt`
    version `>= 2.0.0 < 8.0.0`

-   `puppetlabs/concat`
    version `>= 5.0.0 < 7.0.0`

-   `puppetlabs/stdlib`
    version `>= 4.25.0 < 7.0.0`

-   `puppetlabs/translate`
    version `>= 1.0.0 < 3.0.0`

-   `puppet`
    version `>= 5.5.8 < 7.0.0`

For an extensive list of requirements, see `metadata.json`.

### Beginning with InfluxDB

The module comes along with several configuration files, which you can find in
`templates`. Change configuration settings in according Hiera level.

- `influxdb.conf.erb` and directory `influxdb.conf`
- `service-defaults.erb`
- `systemd.service.erb`

Please refer to [InfluxData documentation](https://www.influxdata.com/) for the
defaults used.

## Usage

```
include ::influxdb
```

## Reference

Please see document `REFERENCE.md`.


## Limitations

-   Please be aware that this module uses "hiera".

-   Tests had been executed on:
    - CentOS 7
    - Debian 10
    - Ubuntu 18.04

For an extensive list of supported operating systems, see `metadata.json`.


## Development

-   pdk-version     1.15.0
-   template-url    pdk-default 1.15.0
-   template-ref    tags/1.15.0-0-g0bc522e


## Release Notes/Contributors/Etc.

-   module:     kogitoapp-influxdb
-   version:    0.1.0
-   author:     Kogito UG <hello@kogito.network>
-   summary:    Module for configuring InfluxDB
-   license:    Apache-2.0
-   source:     https://github.com/kogitoapp/puppet-influxdb

[travis-image]: https://travis-ci.com/kogitoapp/puppet-influxdb.svg
[travis-url]: https://travis-ci.com/kogitoapp/puppet-influxdb
