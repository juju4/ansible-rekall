
require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('rekall-server') do
  it { should be_enabled }
  it { should be_running }
end
describe service('rekall-server@http_server') do
  it { should be_running }
end
describe service('rekall-server@worker') do
  it { should be_running }
end
describe service('rekall-server@agent_controller') do
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
describe file('/tmp/new_HTTP/server.config.yaml') do
  it { should exist }
end
describe file('/tmp/new_HTTP/client.config.yaml') do
  it { should exist }
end

