$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'resque'
require 'resque-remora'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

#
# make sure we can run redis
#
if !system("which redis-server")
  puts '', "** can't find `redis-server` in your path"
  puts "** add redis-server to your PATH and try again"
  abort ''
end

dir = File.dirname(__FILE__)
#
# start our own redis when the tests start,
# kill it when they end
#

at_exit do
  `rm -f #{dir}/dump.rdb`
  pid = `ps -e -o pid,command | grep [r]edis.*9736`.split(" ")[0]
  if pid.to_i >= 100
    puts "Killing test redis server [#{pid}]..."
    Process.kill("KILL", pid.to_i)
  else
    puts "Found #{pid} for resque-server that is probably not resque, so not killing it."
  end
end

puts "Starting redis for testing at localhost:9736..."
`redis-server #{dir}/redis-test.conf`
Resque.redis = 'localhost:9736'
ENV['VERBOSE'] = 'true'

RSpec.configure do |config|
  config.before(:each) do
    Resque.redis.flushall
  end
end
