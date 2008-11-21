require 'original_value'

module ActsAsOverridable
  def self.included(base)
    base.extend(ActMethods)
  end

  module ActMethods
    def has_overridable_attributes(*options)
      unless included_modules.include? InstanceMethods
        extend ClassMethods
        include InstanceMethods
      end

      cattr_reader :overridable_attributes
      conditions = []
      conditions << "model = '#{self}'"

      overridable_attributes = self.overridable_attributes
      overridable_attributes = self.column_names - ['id']

      if options.include?(:only)
        overridable_attributes = overridable_attributes & options[:only]
      elsif options.include?(:except)
        overridable_attributes = overridable_attributes - options[:except]
      end

      conditions << "attribute IN ('#{overridable_attributes.join('\',\'')}')"

      has_many :original_values, :class_name => "OriginalValue",
        :conditions => conditions, :foreign_key => 'model_id'

      overridable_attributes.each do |attribute|
        create_original_value_methods(attribute)
      end

      #alias_method_chain(:save, :overridable_attributes)
    end
  end #ActMethods

  module ClassMethods
    def create_original_value_methods(attribute)
      define_method("#{attribute}_original_value") do
        original_value = original_values.find_by_attribute(attribute)
        original_value.model_value #Nog typecasten
      end
      define_method("#{attribute}_original_value=") do |value|
        original_value = original_values.find_by_attribute(attribute)
        original_value.model_value = value
        original_value.save #mhzzzz....
      end
    end
  end

  module InstanceMethods

    def do_overridables
      #verplaats originele waarde naar andere tabel, => gewoon
      attributes.each do |key, value|
        if !overridden?(key) && self.send("#{key}_changed?")
          self.original_values << OriginalValue.new(:model => self.class,
            :attribute => key, :model_id => self.id,
            :model_value => self.send("#{key}_change").first
          )
        end
      end
    end

    def save_with_overridable_attributes
      do_overridables
      save_without_overridable_attributes
    end

    def save_without_overridable_attributes
      save
    end

    def overridden?(attribute)
      original_values.to_a.include?(attribute.to_sym)
    end
  end

end #ActsAsOverridable