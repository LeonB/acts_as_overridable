namespace :acts_as_overridable do
  namespace :db do
    desc "Creates Magic tables for use with acts_as_overridable"
    task :create => :environment do
      raise "Task unavailable to this database (no migration support)" unless ActiveRecord::Base.connection.supports_migrations?
      require 'rails_generator'
      require 'rails_generator/scripts/generate'
      Rails::Generator::Scripts::Generate.new.run([ "acts_as_overridable", "create_original_values_table" ])
    end
  end
end
