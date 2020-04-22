class CreatePlayerMovesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :player_moves do |t|
        t.string :attack
        t.string :defense
        t.string :wildcard
        t.integer :player_id

        t.timestamps
    end
end
end
