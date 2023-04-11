class AddParentVibrationIdToVibrations < ActiveRecord::Migration[7.0]
  def change
    add_column :vibrations, :parent_vibration_id, :bigint, index: true
    add_foreign_key :vibrations, :vibrations, column: :parent_vibration_id
  end
end
