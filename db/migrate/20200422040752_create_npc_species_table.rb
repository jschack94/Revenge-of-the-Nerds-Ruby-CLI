class CreateNpcSpeciesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :npc_species do |t|
        t.integer :hp
        t.integer :iq
        t.integer :str 
        t.integer :lk
        t.string :npc_attack
        t.string :npc_defense
        t.string :ult

        t.timestamps
    end
end
end