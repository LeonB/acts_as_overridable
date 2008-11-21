class Car < ActiveRecord::Base
  has_overridable_attributes :only => [:brand, 'modeltype', 'number_of_wheels']
end