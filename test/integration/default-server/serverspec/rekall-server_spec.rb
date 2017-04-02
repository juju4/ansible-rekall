
require 'serverspec'

# Required by serverspec
set :backend, :exec

set rekallserver_etc = '/etc/rekall-server'

describe service('rekall-server') do
  it { should be_enabled }
  it { should be_running }
end
describe service('rekall-server@http_server') do
  it { should be_running }
end
describe service('rekall-server-worker') do
  it { should be_running }
end
describe service('rekall-agent') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/usr/local/share/env-rekall/bin/rekall') do
  it { should exist }
  it { should be_executable }
end
describe file("#{rekallserver_etc}/server.config.yaml") do
  it { should exist }
end
describe file("#{rekallserver_etc}/client.config.yaml") do
  it { should exist }
end

describe port(8000) do
  it { should be_listening.with('tcp') }
end

describe command("/usr/local/bin/rekall --agent_config #{rekallserver_etc}/server.config.yaml run --script \"session.SetParameter('agent_mode', 'controller'); show_clients()\"") do
  its(:stdout) { should match /default-server-/ }
## might be splitted in 2 lines...
  its(:stdout) { should match /Linux/ }
  its(:stdout) { should match /64bit/ }
  its(:stdout) { should_not match /Error code 404./ }
#  its(:stderr) { should match /No such file or directory/ }
  its(:exit_status) { should eq 0 }
end

describe file('/var/log/syslog'), :if => os[:family] == 'ubuntu' do
  it { should exist }
  it { should be_file }
  its(:content) { should match /rekall.*:Serving HTTP on 127.0.0.1 port 8000/ }
  its(:content) { should match /rekall.*GET \/tickets\/HuntStatus\?action/ }
  its(:content) { should_not match /rekall.*IOError: / }
end
describe file('/var/log/messages'), :if => os[:family] == 'redhat' do
  it { should exist }
  it { should be_file }
  its(:content) { should match /rekall.*:Serving HTTP on 127.0.0.1 port 8000/ }
  its(:content) { should match /rekall.*GET \/tickets\/HuntStatus\?action/ }
  its(:content) { should_not match /rekall.*IOError: / }
end

