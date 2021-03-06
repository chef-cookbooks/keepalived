unified_mode true

property :helo_name,          String
property :delay_before_retry, Integer
property :connect_ip,         String
property :connect_port,       Integer, equal_to: 1.upto(65_535)
property :connect_timeout,    Integer
property :bind_to,            String
property :bind_port,          Integer, equal_to: 1.upto(65_535)
property :fwmark,             Integer
property :warmup,             Integer
property :config_directory,   String, default: '/etc/keepalived/checks.d'
property :config_file,        String, default: lazy { ::File.join(config_directory, "keepalived_smtp_check__#{name.to_s.gsub(/\s+/, '-')}__.conf") }
property :cookbook,           String, default: 'keepalived'
property :source,             String, default: 'smtp_check.conf.erb'

action :create do
  template new_resource.config_file do
    source new_resource.source
    cookbook new_resource.cookbook
    variables(
      helo_name: new_resource.helo_name,
      delay_before_retry: new_resource.delay_before_retry,
      connect_ip: new_resource.connect_ip,
      connect_port: new_resource.connect_port,
      bind_to: new_resource.bind_to,
      bind_port: new_resource.bind_port,
      connect_timeout: new_resource.connect_timeout,
      fwmark: new_resource.fwmark,
      warmup: new_resource.warmup
    )
    owner 'root'
    group 'root'
    mode '0640'
    action :create
  end
end

action :delete do
  file new_resource.config_file do
    action :delete
  end
end
