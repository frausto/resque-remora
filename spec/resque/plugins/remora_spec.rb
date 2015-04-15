require 'spec_helper'

describe Resque::Plugins::Remora do
  subject { Resque::Plugins::Remora }

  before do
    @now = Time.now
    Time.stub(:now => @now)
  end

  it "should be a valid resque plugin" do
    Resque::Plugin.lint(Resque::Plugins::Remora)
  end

  describe "#process_remora" do

    before do
      @worker = Resque::Worker.new(:test)
      @worker.term_child = true
    end

    it "should process a remora job" do
      Resque.enqueue(TestJob, "arg1")
      @worker.work(0)
      Resque.redis.get("time").should == @now.to_i.to_s
      Resque.redis.get("queue").should == "test"
    end

    it "should process multiple remora jobs with different arguments" do
      Resque.enqueue(TestJob, "arg1")
      now2 = Time.now
      Time.stub(:now => now2)
      Resque.enqueue(TestJob, "arg2")

      @worker.work(0)
      Resque.redis.get(@now.to_i).should == "true"
      Resque.redis.get(now2.to_i).should == "true"
    end
  end
end
