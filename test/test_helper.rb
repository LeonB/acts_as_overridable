require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require File.expand_path(File.dirname(__FILE__) + "/../lib/acts_as_overridable.rb")

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
require File.expand_path(File.dirname(__FILE__) + "/fixtures/schema.rb")

require 'init.rb'
require 'test/models/car.rb'
require 'test/models/person'