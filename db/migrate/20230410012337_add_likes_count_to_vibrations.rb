class AddLikesCountToVibrations < ActiveRecord::Migration[7.0]
  def up
    add_column :vibrations, :likes_count, :integer, null: false, default: 0

    Vibration.find_each do |vibration|
      vibration.update! likes_count: vibration.likes.size
    end
  end

  def down
    remove_column :vibrations, :likes_count
  end
end
