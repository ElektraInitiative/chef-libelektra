# kdb_cookbook_library

Provides resources to interact with the key database of the elektra configuration framework (https://www.libelektra.org). 

## Usage 

The kdbset resource allows to create or update and delete keys in the key database. The kdbmount resource mounts and unmounts configuration files.
The default recipe gives an example on how the resources could be used for new recipes. 

## Requirements

* elektra (https://github.com/ElektraInitiative/libelektra/blob/master/doc/INSTALL.md)

## Default Recipe

The default recipe demonstrates how to add a new configuration value to the etc/hosts file. In the first step the file
is mounted into the key database using the system namespace. A new configuration value is added to the file via kdbset in
the second step. The third step removes the configuration file from the key database. If you open the file afterwards you can
find a new entry. Using the :delete action of kdbset could remove the key from the file. 

## Resources

### kdbset

Creates, updates and deletes key from the key database.

### Actions

* create
* delete

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
| plugins       | string | list of elektra plugins to be used, each plugin can be <br> configured by a comma separated list of keys=values     |

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
