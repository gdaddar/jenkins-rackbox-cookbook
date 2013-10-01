#
# Cookbook Name:: rackbox
# Recipe:: default
#

`hostname 0.0.0.0`

package "libsqlite3-dev"
package "libpq-dev"
package "postgresql"

include_recipe "appbox"
include_recipe "mysql"
include_recipe "sqlite"
include_recipe "postgresql"
include_recipe "nodejs" #to cut down on compile time
include_recipe "runit"

include_recipe "java"
include_recipe "jenkins"

# include_recipe "rackbox::ruby"
include_recipe "rackbox::nginx"
include_recipe "rackbox::jenkins"

include_recipe "imagemagick"
include_recipe "imagemagick::devel"
include_recipe "imagemagick::rmagick"

if node["rackbox"]["apps"]["unicorn"]
  include_recipe "rackbox::unicorn"
end

if node["rackbox"]["apps"]["passenger"]
  include_recipe "rackbox::passenger"
end

unless node["rackbox"]["databases"].nil?
  if node["rackbox"]["databases"]["postgresql"]
    include_recipe "rackbox::postgresql"
  end
end
