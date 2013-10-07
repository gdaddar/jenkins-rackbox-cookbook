name             "jenkinsbox" #"rackbox"
maintainer       "Huiming Teo"
maintainer_email "teohuiming@gmail.com"
license          "Apache License 2.0"
description      "Setup a rack-based application server to run unicorn and passenger apps."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

recipe "rackbox", "run all recipes."
recipe "rackbox::ruby", "setup a ruby version manager `rbenv`."
recipe "rackbox::nginx", "setup `nginx` as front-end server."
recipe "rackbox::unicorn", "setup `unicorn` apps, if any."
recipe "rackbox::passenger", "setup `passenger` apps, if any."
recipe "rackbox::postgresql", "Install PostgreSQL and create PostgreSQL databases."
recipe "rackbox::jenkins", "setup jenkins with a new job"

supports 'ubuntu'
supports 'debian'

depends 'build-essential'
depends 'appbox'
#depends 'database'
depends 'imagemagick'
depends 'mysql'
depends 'sqlite'
depends 'postgresql'
#depends 'nodejs' #to cut down on compile time
depends 'rbenv'
depends 'nginx'
depends 'unicorn', ">= 1.2.2"
depends 'runit', '>= 1.1.2'

depends 'java'
depends 'jenkins'
