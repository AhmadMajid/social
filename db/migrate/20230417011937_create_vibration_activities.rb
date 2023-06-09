class CreateVibrationActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :vibration_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vibration, null: false, foreign_key: true
      t.string :verb, null: false

      t.timestamps
    end
  end
end
