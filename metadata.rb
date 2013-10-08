name             "jenkinsbox" #"jenkinsbox"
maintainer       "Huiming Teo"
maintainer_email "teohuiming@gmail.com"
license          "Apache License 2.0"
description      "Setup a rack-based application server to run unicorn and passenger apps."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

recipe "jenkinsbox", "run all recipes."
#recipe "jenkinsbox::ruby", "setup a ruby version manager `rbenv`."
recipe "jenkinsbox::postgresql", "Install PostgreSQL and create PostgreSQL databases."
recipe "jenkinsbox::jenkins", "setup jenkins with a new job"

supports 'ubuntu'
supports 'debian'

depends 'appbox'
depends 'database'
depends 'imagemagick'
depends 'mysql'
depends 'sqlite'
depends 'postgresql'
#depends 'nodejs' #to cut down on compile time
#depends 'rbenv'
depends 'runit', '>= 1.1.2'

depends 'java'
depends 'jenkins'
