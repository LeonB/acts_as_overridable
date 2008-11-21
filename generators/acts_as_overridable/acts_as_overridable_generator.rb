class ActsAsOverridableGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      m.migration_template 'migration.rb', 'db/migrate'
    end
  end
end
