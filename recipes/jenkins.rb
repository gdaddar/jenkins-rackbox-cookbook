#
# Cookbook Name:: rackbox
# Recipe:: jenkins
#
# Install and setup Jenkins environment
#
puts "jabberwocky"
puts node["jenkins"]["server"]["version"]

include_recipe "java"
include_recipe "jenkins"


ip_address = node["rackbox"]["jenkins"]["ip_address"]
host = node["rackbox"]['jenkins']['host']
puts host



#`git config --global user.name "Your Name"`
#`git config --global user.email "your_email@example.com"`

#`hostname 0.0.0.0`
`sudo wget -O default.js http://updates.jenkins-ci.org/update-center.json`
`sudo sed '1d;$d' default.js > default.json`
`sudo mkdir /var/lib/jenkins/updates`
`sudo mv default.json /var/lib/jenkins/updates/`
`sudo chown -R jenkins:nogroup /var/lib/jenkins/updates`

directory "#{node[:jenkins][:server][:home]}" do
  owner "#{node[:jenkins][:server][:user]}"
  group "#{node[:jenkins][:server][:user]}"
  action :create
end

execute "update jenkins update center" do
  command "wget http://updates.jenkins-ci.org/update-center.json -qO- | sed '1d;$d'  > #{node[:jenkins][:server][:home]}/updates/default.json"
  user "#{node[:jenkins][:server][:user]}"
  group "#{node[:jenkins][:server][:user]}"
  creates "#{node[:jenkins][:server][:home]}/updates/default.json"
end

%w(github rbenv).each do |plugin|
  jenkins_cli "install-plugin #{plugin}"

end

#jenkins_cli "safe-restart"
#
#jenkins_cli "install-plugin github"
#
##jenkins_cli "safe-restart"
#
#jenkins_cli "install-plugin rbenv"
#
##jenkins_cli "safe-restart"


git_repo = node["rackbox"]["jenkins"]["git_repo"]
build_command = node["rackbox"]["jenkins"]["command"]
job_name = node["rackbox"]["jenkins"]["job"]
node["rackbox"]["jenkins"]["ip_address"]

template '/home/jj-config.xml' do
  source 'jenkins-job_config.xml.erb'
  variables ({:git_url => git_repo, :build_command => build_command})
end

jenkins_cli "create-job #{job_name} < /home/jj-config.xml" unless File.exist? ("/var/lib/jenkins/jobs/#{job_name}/config.xml")

template '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml' do
  source 'jenkins-git-config.xml.erb'
end

jenkins_cli "safe-restart"

#template = File.read("#{Dir.pwd}/default/jenkins-job_config.xml.erb")
#template = Erubis::Eruby.new(template)
#config = template.result(:git_url => git_repo, :build_command => build_command)
#out_file = File.new("config.xml", "w")
#out_file.puts(config)
#out_file.close


