class AddReplyVibrationsCountToVibrations < ActiveRecord::Migration[7.0]
  def change
    add_column :vibrations, :reply_vibrations_count, :integer, null: false, default: 0
  end
end
