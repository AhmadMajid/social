class CreateVibrations < ActiveRecord::Migration[7.0]
  def change
    create_table :vibrations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
