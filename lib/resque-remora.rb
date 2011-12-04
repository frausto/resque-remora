require 'resque'
require 'resque/plugins/remora'
require 'resque/plugins/remora/push_pop'

module Resque
  include Resque::Plugins::Remora::PushPop
end