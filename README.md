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

-   manages GPG key, repository (manage_repo = true)

-   manages package

-   manages directories and configuration files (referring to templates)
    -   `/etc/influxdb/influxdb.conf`
    -   `/etc/default/influxdb`
    -   `/lib/systemd/system/influxdb.service`

-   starts service "influxdb" immediately

### Setup Requirements

For an extensive list of requirements, see `metadata.json`.

### Beginning with InfluxDB

The module comes along with several configuration files, which you can find in
`templates`. Change configuration settings using according hashes or hiera.

- `influxdb.conf.erb`
- `service-defaults.erb`
- `systemd.service.erb`

Please refer to [InfluxData documentation](https://www.influxdata.com/) for the
defaults used.

## Usage

```
include ::influxdb

```

### In combination with other influxdata module

* when influxdb shall handle GPG keys and repository
```
class { 'influxdb':
  manage_repo => true,
}
```

* when one of the other influxdata modules already handles GPG keys and repository
```
class { 'influxdb':
  manage_repo => false,
}
```

### Set up databases, users and grants

```
influxdb::database {'telegraf1':
  ensure => present,
}
```

```
influxdb::user{'telegraf1':
  passwd => 'metricsmetricsmetrics',
}
```

```
influxdb::grant{'telegraf1':
  grant    => 'WRITE',
  database => 'telegraf',
}
```

## Reference

Please see document `REFERENCE.md`.


## Limitations

-   Tests had been executed on:
    - CentOS 7.8
    - Debian 10.4
    - Ubuntu 18.04

For an extensive list of supported operating systems, see `metadata.json`.


## Development

-   pdk-version     1.18.0
-   template-url    pdk-default 1.18.0
-   template-ref    tags/1.18.0-0-g095317c


## Release Notes/Contributors/Etc.

-   module:     kogitoapp-influxdb
-   version:    0.1.0
-   author:     Kogito UG <hello@kogito.network>
-   summary:    Module for configuring InfluxDB
-   license:    Apache-2.0
-   source:     https://github.com/kogitoapp/puppet-influxdb

[travis-image]: https://travis-ci.com/kogitoapp/puppet-influxdb.svg
[travis-url]: https://travis-ci.com/kogitoapp/puppet-influxdb
