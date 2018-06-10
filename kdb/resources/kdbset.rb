resource_name :kdbset

property :key, String, name_property: true
property :value, String, required: true
property :namespace, String

action :create do
  execute 'set_value' do
    if new_resource.namespace.nil?
        command "kdb set #{new_resource.key} '#{new_resource.value}'"
    else 
        command "kdb set -N #{new_resource.namespace} #{new_resource.key} '#{new_resource.value}'"
    end
  end
end

action :delete do
  execute 'remove_value' do
    command "kdb rm #{new_resource.key}"
  end
end
