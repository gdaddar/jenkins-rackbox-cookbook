#
# Cookbook Name:: jenkinsbox
# Recipe:: jenkins
#
# Install and setup Jenkins environment
#
puts "jabberwocky"
puts node["jenkins"]["server"]["version"]

include_recipe "java"
include_recipe "jenkins"


ip_address = node["jenkinsbox"]["jenkins"]["ip_address"]

directory "#{node[:jenkins][:server][:home]}" do
  owner "#{node[:jenkins][:server][:user]}"
  group "#{node[:jenkins][:server][:user]}"
  action :create
end

directory "/var/lib/jenkins/updates" do
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

git_repo = node["jenkinsbox"]["jenkins"]["git_repo"]
build_command = node["jenkinsbox"]["jenkins"]["command"]
job_name = node["jenkinsbox"]["jenkins"]["job"]
node["jenkinsbox"]["jenkins"]["ip_address"]

template '/home/jj-config.xml' do
  source 'jenkins-job_config.xml.erb'
  variables ({:git_url => git_repo, :build_command => build_command})
end

jenkins_cli "create-job #{job_name} < /home/jj-config.xml" unless File.exist? ("/var/lib/jenkins/jobs/#{job_name}/config.xml")

template '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml' do
  source 'jenkins-git-config.xml.erb'
end

jenkins_cli "safe-restart"