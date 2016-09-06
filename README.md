# MkGreenwich

## Installation

This is the gem library which calculates Greenwich time.

```ruby
gem 'mk_greenwich'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mk_greenwich

## Usage

### Instantiation

    require 'mk_greenwich'
    
    g = MkGreenwich.new("20160906")
    g = MkGreenwich.new("20160906123456")
    g = MkGreenwich.new

* You can set UTC formatted "YYYYMMDD" or "YYYYMMDDHHMMSS" as an argument.
* If you don't set an argument, this class considers the system time to have been set as an argument.

### Calculation

    puts " UTC: #{g.utc.instance_eval { '%s.%03d' % [strftime('%Y-%m-%d %H:%M:%S'), (usec / 1000.0).round] }}"
    puts "  TT: #{g.tt.instance_eval { '%s.%03d' % [strftime('%Y-%m-%d %H:%M:%S'), (usec / 1000.0).round] }}"
    puts " UT1: #{g.ut1.instance_eval { '%s.%03d' % [strftime('%Y-%m-%d %H:%M:%S'), (usec / 1000.0).round] }}"
    puts " TDB: #{g.tdb.instance_eval { '%s.%03d' % [strftime('%Y-%m-%d %H:%M:%S'), (usec / 1000.0).round] }}"
    puts " ERA: #{g.era}"
    puts "  EO: #{g.eo}"
    puts "GAST: #{g.gast} rad"
    puts "    = #{g.gast_deg} °"
    puts "    = #{g.gast_hms}"
    puts "GMST: #{g.gmst} rad"
    puts "    = #{g.gmst_deg} °"
    puts "    = #{g.gmst_hms}"
    puts "  EE: #{g.ee} rad"
    puts "    = #{g.ee_deg} °"
    puts "    = #{g.ee_hms}"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/komasaru/mk_greenwich.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

