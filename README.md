# Puppet module to manage InfluxDB Server

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

Installs, configures and starts the service of InfluxDB Server.
It can be used as a Puppet module.

Please refer also to https://www.influxdata.com/

## Setup

### What InfluxDB affects **OPTIONAL**

stances.

If there's more that they should know about, though, this is the place to mention:

* Files, packages, services, or operations that the module will alter, impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled, another module, etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps for upgrading, you might want to include an additional "Upgrading" section here.

### Beginning with InfluxDB

The module comes along with three configuration files, which you can find in "templates".

- InfluxDB.conf.erb
- service-defaults.erb
- systemd.service.erb

You have to change the network parameters to have InfluxDB up and running.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

Please see document REFERENCE.md.


## Limitations

This module had been tested with:

- InfluxDB 1.7.10 stable
- Puppet 5.5.18
- Ubuntu bionic amd64 x86_64

Please be aware that this module uses Hiera.

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
