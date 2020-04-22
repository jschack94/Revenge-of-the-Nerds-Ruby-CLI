class CreateBattlesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :battles do |t|
        t.integer :player_id
        t.integer :npc_id
        t.boolean :player_win
        

        t.timestamps
    end
end
end