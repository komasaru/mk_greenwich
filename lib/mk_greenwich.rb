require "date"
require "eph_bpn"
require "mk_time"
require "mk_greenwich/version"
require "mk_greenwich/argument"
require "mk_greenwich/const"
require "mk_greenwich/cip_cio"
require "mk_greenwich/era_eors"
require "mk_greenwich/greenwich"

module MkGreenwich
  def self.new(arg)
    arg ||= Time.now.strftime("%Y%m%d%H%M%S")
    ut = MkGreenwich::Argument.new(arg).get_utc
    return unless ut
    return MkGreenwich::Greenwich.new(ut)
  end
end
