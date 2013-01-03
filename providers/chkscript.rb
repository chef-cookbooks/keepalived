
action :create do
  template new_resource.name do
    path "/etc/keepalived/conf.d/script_#{new_resource.name}.conf"
    source "script_generic.conf.erb"
    cookbook "keepalived"
    owner "root"
    group "root"
    mode "0644"
    variables(
      "name" => new_resource.name,
      "script" => new_resource.script,
      "interval" => new_resource.interval,
      "weight" => new_resource.weight
    )
    notifies :restart, resource(:service => "keepalived"), :delayed
  end
  new_resource.updated_by_last_action(true)
end