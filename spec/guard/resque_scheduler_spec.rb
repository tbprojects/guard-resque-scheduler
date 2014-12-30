require 'spec_helper'

describe Guard::ResqueScheduler do
  let(:default) { double("Guard::Group") }
  let(:test) { double("Guard::Group") }

  let(:session) { double("Guard::Internals::Session") }
  let(:groups) { double("Guard::Internals::Groups") }
  let(:state) { double("Guard::Internals::State") }

  before do
    groups.stub(:add).with(:default).and_return(default)
    groups.stub(:add).with(:test).and_return(test)

    session.stub(:groups).and_return(groups)
    state.stub(:session).and_return(session)
    Guard.stub(:state).and_return(state)
  end  
  
  describe 'start' do
    it 'should accept :environment option' do
      environment = :foo

      obj = Guard::ResqueScheduler.new :environment => environment
      obj.send(:env).should include 'RAILS_ENV' => environment.to_s
    end

    it 'should accept :verbose option' do
      obj = Guard::ResqueScheduler.new :verbose => true
      obj.send(:env).should include 'VERBOSE'
    end

    it 'should accept :trace option' do
      obj = Guard::ResqueScheduler.new :trace => true
      obj.send(:cmd).should include '--trace'
    end

    it 'should accept :task option' do
      task = 'environment foo'

      obj = Guard::ResqueScheduler.new :task => task
      obj.send(:cmd).should include task
      obj.send(:cmd).should_not include Guard::ResqueScheduler::DEFAULT_TASK
    end

    it 'should provide default options' do
      obj = Guard::ResqueScheduler.new
      obj.send(:cmd).should include Guard::ResqueScheduler::DEFAULT_TASK
    end
  end
end
