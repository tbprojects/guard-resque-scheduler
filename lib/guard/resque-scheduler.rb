require 'guard'
require 'guard/guard'
require 'timeout'

module Guard
  class ResqueScheduler < Guard

    DEFAULT_SIGNAL = :QUIT
    DEFAULT_TASK = 'resque:scheduler'.freeze

    # Allowable options are:
    #  - :environment  e.g. 'test'
    #  - :task .e.g 'resque:work'
    #  - :verbose e.g. true
    #  - :trace e.g. true
    #  - :stop_signal e.g. :QUIT or :SIGQUIT
    def initialize(watchers = [], options = {})
      @options = options
      @pid = nil
      @stop_signal = options[:stop_signal] || DEFAULT_SIGNAL
      @options[:task] ||= DEFAULT_TASK
      super
    end

    def start
      stop
      UI.info 'Starting up resque-scheduler...'
      UI.info [ cmd, env.map{|v| v.join('=')} ].join(' ')

      # Launch ResqueScheduler
      @pid = spawn(env, cmd)
    end

    def stop
      if @pid
        UI.info 'Stopping resque-scheduler...'
        ::Process.kill @stop_signal, @pid
        begin
          Timeout.timeout(15) do
            ::Process.wait @pid
          end
        rescue Timeout::Error
          UI.info 'Sending SIGKILL to resque-scheduler, as it\'s taking too long to shutdown.'
          ::Process.kill :KILL, @pid
          ::Process.wait @pid
        end
        UI.info 'Stopped process resque-scheduler'
      end
    rescue Errno::ESRCH
      UI.info 'Guard::ResqueScheduler lost the ResqueScheduler worker subprocess!'
    ensure
      @pid = nil
    end

    # Called on Ctrl-Z signal
    def reload
      UI.info 'Restarting resque-scheduler...'
      restart
    end

    # Called on Ctrl-/ signal
    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_change(paths)
      restart
    end

    def restart
      stop
      start
    end

    private

    def cmd
      command = ['bundle exec rake', @options[:task].to_s]

      # trace setting
      command << '--trace' if @options[:trace]

      return command.join(' ')
    end

    def env
      var = Hash.new

      var['RAILS_ENV'] = @options[:environment].to_s if @options[:environment]

      var['VERBOSE']  = '1' if @options[:verbose]

      return var
    end
  end
end

