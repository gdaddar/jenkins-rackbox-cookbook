#
# Cookbook Name:: jenkinsbox
# Recipe:: jenkins
#
# Install and setup Jenkins environment
#
include_recipe "java"
include_recipe "jenkins"

git_name = node["jenkinsbox"]["jenkins"]["git_name"]
git_email = node["jenkinsbox"]["jenkins"]["git_email"]
#job_name = node["jenkinsbox"]["jenkins"]["job"]

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

#template '/home/jj-config.xml' do
#  source 'jenkins-job_config.xml.erb'
#  variables ({:git_url => git_repo, :build_command => build_command})
#end
#
#jenkins_cli "create-job #{job_name} < /home/jj-config.xml" unless File.exist? ("/var/lib/jenkins/jobs/#{job_name}/config.xml")

template '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml' do
  source 'jenkins-git-config.xml.erb'
  variables ({:git_name => git_name, :git_email => git_email})
end

jenkins_cli "safe-restart"