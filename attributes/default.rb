#default["jenkinsbox"]["default_config"]["build_essential"]["compiletime"] = true
node.override['build_essential']["compiletime"] = true
node.override['jenkins']['server']['url'] = 'http://0.0.0.0:8080'#'http://0.0.0.0'

default["jenkinsbox"]["ruby"]["versions"] = %w(1.9.3-p385)
default["jenkinsbox"]["ruby"]["global_version"] = "1.9.3-p385"
default["jenkinsbox"]["upstream_start_port"]["unicorn"] = 10001
default["jenkinsbox"]["upstream_start_port"]["passenger"] = 20001

default["jenkinsbox"]["default_config"]["nginx"]["template_name"] = "nginx_vhost.conf.erb"
default["jenkinsbox"]["default_config"]["nginx"]["template_cookbook"] = "jenkinsbox"
default["jenkinsbox"]["default_config"]["nginx"]["listen_port"] = "80"

default["jenkinsbox"]["default_config"]["unicorn"]["listen_port_options"] = { :tcp_nodelay => true, :backlog => 100 }
default["jenkinsbox"]["default_config"]["unicorn"]["worker_timeout"] = 60
default["jenkinsbox"]["default_config"]["unicorn"]["preload_app"] = false
default["jenkinsbox"]["default_config"]["unicorn"]["worker_processes"] = [node[:cpu][:total].to_i * 4, 8].min
default["jenkinsbox"]["default_config"]["unicorn"]["before_fork"] = 'sleep 1'

default["jenkinsbox"]["default_config"]["unicorn_runit"]["template_name"] = "unicorn"
default["jenkinsbox"]["default_config"]["unicorn_runit"]["template_cookbook"] = "jenkinsbox"
default["jenkinsbox"]["default_config"]["unicorn_runit"]["rack_env"] = "production"

default["jenkinsbox"]["default_config"]["passenger_runit"]["template_name"] = "passenger"
default["jenkinsbox"]["default_config"]["passenger_runit"]["template_cookbook"] = "jenkinsbox"
default["jenkinsbox"]["default_config"]["passenger_runit"]["rack_env"] = "production"
default["jenkinsbox"]["default_config"]["passenger_runit"]["max_pool_size"] = 6
default["jenkinsbox"]["default_config"]["passenger_runit"]["min_instances"] = 1
default["jenkinsbox"]["default_config"]["passenger_runit"]["spawn_method"] = "smart-lv2"
default["jenkinsbox"]["default_config"]["passenger_runit"]["host"] = "localhost"

default["jenkinsbox"]["apps"]["unicorn"] = []
default["jenkinsbox"]["apps"]["passenger"] = []

set['nginx']['init_style'] = "init"

