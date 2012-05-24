require 'pathname'
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'

unless defined? BioRubyTestDataPath and BioRubyTestDataPath
  test_data_path = Pathname.new(File.join(File.dirname(__FILE__),
                                          "data")).cleanpath.to_s
  test_data_path.freeze
  BioRubyTestDataPath = test_data_path
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bio-phyloxml'

class Test::Unit::TestCase
end