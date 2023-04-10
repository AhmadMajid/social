class AddViewsCountToVibrations < ActiveRecord::Migration[7.0]
  def change
    add_column :vibrations, :views_count, :integer
  end
end
