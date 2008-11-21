module ActsAsOverridable
  class OriginalValue < ActiveRecord::Base
    def model=(model)
      write_attribute(:model, model.to_s)
    end
  
    def ==(other)
      if other.is_a?(Symbol)
        return self.attribute.to_sym == other
      end
      super
    end
  end
end #ActsAsOverrideable