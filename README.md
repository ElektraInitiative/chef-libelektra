# kdb_cookbook_library

Elektra stores configuration in a global, hierarchical key database.
It supports seamless integration and introspection by mounting configuration files into the key database.
[See the homepage for more information.](https://www.libelektra.org).
This cookbook configures applications with Elektra.

## Usage 

The kdbset resource allows us to create (or update) and delete keys in the key database.
The kdbmount resource mounts (and unmounts) configuration files into the key database.
The default recipe gives an example on how the resources can be used for new recipes.

## Requirements

* Elektra (https://www.libelektra.org/docgettingstarted/installation)

## Platform Support

* Linux
* BSD
* Mac OS X
* Windows (mingw)

## Default Recipe

The default recipe demonstrates how to add a new configuration value to the `/etc/hosts` file:

1. In the first step the file is mounted into the key database using the system namespace.
2. In the second step a new configuration value is added to the file via kdbset.
3. The third step removes the configuration file from the key database. If you open the file afterwards you can find a new entry.

## Resources

### kdbset

Creates, updates and deletes key from the key database.

### Actions

* create
* delete

The :delete action of kdbset removes the key from the file. 

### Attribute Parameters

| Parameter     | Type   | Description                                     |  
| ------------- |:------:|:------------------------------------------------|
| key           | string | path to the key that stores the value           |
| value         | string | configuration value to be stored under key      |  
| namespace     | string | namespace to use when writing cascading keys    |

### Examples

create new key

```
kdbset '/hosts/ipv4/showthatitworks' do
  namespace 'system'
  value '127.0.0.33'
  action :create
end
```

delete existing key

```
kdbset 'system/hosts/ipv4/showthatitworks' do
  action :delete
end
```

### kdbmount

Mounts configuration files into the key database und removes them from the same.

* create
* delete

### Attributes Parameters

| Parameter     | Type   | Description                                             |  
| ------------- |:------:|:--------------------------------------------------------|
| mountpoint    | string | where in the database the new backend should be mounted |
| file          | string | path to the file that should be mounted                 |  
| plugins       | string | list of Elektra plugins to be used, each plugin can be <br> configured by a comma separated list of keys=values     |

### Examples

mount /etc/hosts into the database

```
kdbmount 'system/hosts' do
  file '/etc/hosts'
  plugins 'hosts'
  action :create
end
```

unmounts /etc/hosts from the database

```
kdbmount 'system/hosts' do
  action :delete
end
```

## License

### BSD 3-Clause License

Copyright (c) 2017, Elektra Initiative Some rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

    Neither the name of Elektra nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
