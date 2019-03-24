class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.references :guest, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
