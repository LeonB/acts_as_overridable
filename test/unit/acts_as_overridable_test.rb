require File.dirname(__FILE__) + '/../test_helper'

class ActsAsOverridableTest < ActiveSupport::TestCase

  def setup
    ActsAsOverridable::OriginalValue.delete_all
    Fixtures.create_fixtures('test/fixtures/', ActiveRecord::Base.connection.tables)
  end
  
  def test_without_overrides_attributes_should_be_normal
    leon = Person.find_by_voornaam('Leon')
    leon.save
    assert leon.errors.length == 0

    leon.achternaam = 'Doe'
    leon.save_with_overridable_attributes
    assert leon.errors.length == 0
    assert leon.achternaam = 'Doe'
  end

  def test_overridden_attributes_should_create_new_overridable
    assert ActsAsOverridable::OriginalValue.count == 0
    fiesta = Car.find_by_modeltype('Fiesta')
    fiesta.number_of_wheels = fiesta.number_of_wheels + 1
    fiesta.save_with_overridable_attributes
    assert fiesta.original_values.length == 1
  end

  def test_if_overridden_attribute_exists_show_that_value
    fiesta = Car.find_by_modeltype('Fiesta')
    new_number_of_wheels = fiesta.number_of_wheels + 1
    fiesta.number_of_wheels = new_number_of_wheels
    fiesta.save_with_overridable_attributes
    fiesta = Car.find(fiesta.id)
    assert fiesta.number_of_wheels == new_number_of_wheels
  end

  def test_explicit_save_without_overridable_attributes_shoud_not_create_new_overridable
    assert ActsAsOverridable::OriginalValue.count == 0
    fiesta = Car.find_by_modeltype('Fiesta')
    fiesta.number_of_wheels = fiesta.number_of_wheels + 1
    fiesta.save_without_overridable_attributes
    assert fiesta.original_values.count == 0
  end

  def test_if_new_value_is_the_same_no_original_value_should_be_created
    cubistar = Car.find_by_modeltype('Cubistar')
    cubistar.brand = 'Nissan'
    cubistar.save_with_overridable_attributes
    assert cubistar.brand == 'Nissan'
    assert cubistar.original_values.length == 0
  end

  def test_save_should_not_be_alias_of_save_with_overridable_attributes
    mini = Car.find_by_modeltype('Cooper')
    mini.brand = 'BMW'
    mini.save
    assert mini.original_values.length == 0
  end

  def test_save_should_be_alias_of_save_without_overridable_attributes
    bmw = Car.find_by_modeltype('3 serie')
    bmw.brand = 'BMotorWerken'
    bmw.save_without_overridable_attributes
    assert bmw.brand == 'BMotorWerken'
    assert bmw.original_values.length == 0
  end
end
