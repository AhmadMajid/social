class CreateHashtagsVibrationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtags_vibrations, id: false do |t|
      t.belongs_to :hashtag
      t.belongs_to :vibration

      t.timestamps
    end
  end
end
