# Guard::Resque

Guard::Resque automatically starts/stops/restarts resque scheduler

*forked from [Guard::Resque](http://github.com/railsjedi/guard-resque)*


## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before continue.

Install the gem:

    gem install guard-resque-scheduler

Add it to your Gemfile (inside test group):

    gem 'guard-resque-scheduler'

Add guard definition to your Guardfile by running this command:

    guard init resque-scheduler


## Usage

Please read [Guard usage doc](http://github.com/guard/guard#readme).


## Guardfile

    guard 'resque-scheduler', :environment => 'development' do
      watch('config/schedule.yml')
    end

Scheduler only needs to reload when the schedule changes, so point it there.


## Options

You can customize the resque task via the following options:

* `environment`: the rails environment to run the workers in (defaults to `nil`)
* `task`: the name of the rake task to use (defaults to `"resque:scheduler"`)
* `verbose`: whether to use verbose logging (defaults to `nil`)
* `trace`: whether to include `--trace` on the rake command (defaults to `nil`)
* `stop_signal`: how to kill the process when restarting (defaults to `QUIT`)


## Development

 * Source hosted at [GitHub](http://github.com/dlnichols/resque-scheduler)
 * Report issues/Questions/Feature requests on [GitHub Issues](http://github.com/dlnichols/resque-scheduler/issues)

Pull requests are very welcome! Make sure your patches are well tested.
Please create a topic branch for every separate change you make.


## Testing the gem locally

    gem install guard-resque-scheduler-0.x.x.gem


## Building and deploying gem

 * Update the version number in `lib/guard/resque-scheduler/version.rb`
 * Update `CHANGELOG.md`
 * Build the gem:

    gem build guard-resque-scheduler.gemspec

 * Push to rubygems.org:

    gem push guard-resque-scheduler-0.x.x.gem


## Guard::Delayed Authors

[David Parry](https://github.com/suranyami)
[Dennis Reimann](https://github.com/dbloete)

Ideas for this gem came from [Guard::WEBrick](http://github.com/fnichol/guard-webrick).


## Guard::Resque Author

[Jacques Crocker](https://github.com/railsjedi)

I hacked this together from the `guard-delayed` gem for use with Resque. All credit go to the original authors though. I just search/replaced and tweaked a few things


## Guard::ResqueScheduler Author

[Dan Nichols](https://github.com/dlnichols)

Hacked up Guard::Resque because I needed a simple way to launch the scheduler daemon.  Mostly a search/replace, and I removed some of the resque options that didn't apply.
