require 'spec_helper'

describe Resque::Plugins::Remora::PushPop do
  subject { Resque::Plugins::Remora::PushPop }
  
  before do
    @now = Time.now
    Time.stub(:now => @now)
  end
  
  describe "#push" do
    it "should add the remora information to the end of the job" do
      TestJob.stub(:remora_attachment => {:remora => {:time => @now.to_i, :olah => "oh hai!"}})
      Resque.enqueue(TestJob, "arg1")
      Resque.redis.lindex("queue:test",0).should =~ /^\{.*\"remora\":(\{\"olah\":\"oh hai!\",\"time\":\"#{@now.to_i}\"\}||\{\"time\":\"#{@now.to_i}\",\"olah\":\"oh hai!\"\})/
    end
  end
  
  describe "#pop" do
    before do
      @attachment = {:remora => {:time => @now.to_i, :olah => "oh hai!"}}
      @pop_result = {"args"=>["arg1"], "class"=>"TestJob", "remora"=>{"time"=>@now.to_i, "olah"=>"oh hai!"}}
    end
    
    it "should get the remora information for processing" do
      TestJob.stub(:remora_attachment => @attachment)
      Resque.enqueue(TestJob, "arg1")
      TestJob.should_receive(:process_remora).with("test", {'time' => @now.to_i, 'olah' => "oh hai!"})
      Resque.pop("test").should == @pop_result
    end
    
    it "should not process remora if there is no remora attached to job" do
      TestJob.stub(:remora_attachment => {})
      Resque.enqueue(TestJob, "arg1")
      TestJob.should_not_receive(:process_remora)
      Resque.pop("test").should == {"args"=>["arg1"], "class"=>"TestJob"}
    end
    
    it "should not process remora if the job is not remoraed" do
      Resque.enqueue(NotRemoraTestJob, "arg1")
      NotRemoraTestJob.should_not_receive(:process_remora)
      Resque.pop("not_remora").should == {"args"=>["arg1"], "class"=>"NotRemoraTestJob"}
    end
    
    it "should return the job properly if an exception is thrown in processing remora" do
      TestJob.stub(:remora_attachment => @attachment)
      Resque.enqueue(TestJob, "arg1")
      TestJob.should_receive(:process_remora).and_throw(:Exception)
      Resque.pop("test").should == @pop_result
    end
  end
end