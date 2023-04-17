class AddActorToVibrationActivities < ActiveRecord::Migration[7.0]
  def change
    add_reference :vibration_activities, :actor, null: false, foreign_key: { to_table: :users }
  end
end
