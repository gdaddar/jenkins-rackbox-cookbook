#
# Cookbook Name:: jenkinsbox
# Recipe:: default
#

include_recipe "build-essential"

package "libsqlite3-dev"
package "libpq-dev"
package "libxslt-dev"
package "libxml2-dev"
package "postgresql"

include_recipe "appbox"
include_recipe "mysql"
include_recipe "sqlite"
#include_recipe "nodejs" #to cut down on compile time
include_recipe "runit"

include_recipe "jenkinsbox::postgresql"
#include_recipe "jenkinsbox::ruby"
include_recipe "jenkinsbox::jenkins"

include_recipe "imagemagick"
include_recipe "imagemagick::devel"
include_recipe "imagemagick::rmagick"

unless node["jenkinsbox"]["databases"].nil?
  if node["jenkinsbox"]["databases"]["postgresql"]
    include_recipe "jenkinsbox::postgresql"
  end
end
