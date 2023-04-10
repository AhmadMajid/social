class CreateRevibrations < ActiveRecord::Migration[7.0]
  def change
    create_table :revibrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vibration, null: false, foreign_key: true

      t.index [:user_id, :vibration_id], unique: true

      t.timestamps
    end
  end
end
