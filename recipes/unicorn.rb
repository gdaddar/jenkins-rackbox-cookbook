#
# Cookbook Name:: jenkinsbox
# Recipe:: unicorn
#
# Setup unicorn apps
#

::Chef::Recipe.send(:include, Jenkinsbox::Helpers)

Array(node["jenkinsbox"]["apps"]["unicorn"]).each_with_index do |app, index|
  default_port = node["jenkinsbox"]["upstream_start_port"]["unicorn"].to_i + index
  app_dir      = ::File.join(node["appbox"]["apps_dir"], app["appname"], 'current')

  setup_nginx_site(app, app_dir, default_port)
  setup_unicorn_config(app, app_dir, default_port)
  setup_unicorn_runit(app, app_dir)
end

