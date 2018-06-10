resource_name :kdbmount

property :mountpoint, String, name_property: true, required: true
property :file, String, required: true
property :plugins, String, required: true

action :create do
  execute 'set_value' do
    command "kdb mount #{new_resource.file} #{new_resource.mountpoint} #{new_resource.plugins}"
  end
end

action :delete do
  execute 'remove_value' do
    command "kdb umount #{new_resource.mountpoint}"
  end
end
