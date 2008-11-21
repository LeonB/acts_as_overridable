class CreateOriginalValuesTable < ActiveRecord::Migration
  def self.up
    create_table "original_values", :force => true do |t|
      t.string   "model"
      t.string   "attribute"
      t.integer  "model_id"
      t.string   "model_value"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table "original_values"
  end
end
