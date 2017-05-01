# ProcessLock

[![Code Climate](https://codeclimate.com/github/ForwardFinancing/process_lock/badges/gpa.svg)](https://codeclimate.com/github/ForwardFinancing/process_lock)

[![Test Coverage](https://codeclimate.com/github/ForwardFinancing/process_lock/badges/coverage.svg)](https://codeclimate.com/github/ForwardFinancing/process_lock/coverage)

[![Issue Count](https://codeclimate.com/github/ForwardFinancing/process_lock/badges/issue_count.svg)](https://codeclimate.com/github/ForwardFinancing/process_lock)


[![Build Status](https://travis-ci.org/ForwardFinancing/process_lock.svg?branch=master)](https://travis-ci.org/ForwardFinancing/process_lock)

Ensures that multiple processes cannot be run concurrently, using redis.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'with_process_lock'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install process_lock

## Usage

```
  ProcessLock::WithProcessLock.execute('unique_key_for_your_process') do
    # The code to run in the process
    do_stuff
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/process_lock.
