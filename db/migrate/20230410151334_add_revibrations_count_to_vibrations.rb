class AddRevibrationsCountToVibrations < ActiveRecord::Migration[7.0]
  def change
    add_column :vibrations, :revibrations_count, :integer, null: false, default: 0
  end
end
