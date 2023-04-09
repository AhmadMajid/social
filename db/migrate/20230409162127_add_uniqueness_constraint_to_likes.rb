class AddUniquenessConstraintToLikes < ActiveRecord::Migration[7.0]
  def change
    add_index :likes, [:user_id, :vibration_id], unique: true
  end
end
