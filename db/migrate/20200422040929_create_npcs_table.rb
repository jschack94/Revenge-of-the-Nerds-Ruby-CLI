class CreateNpcsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :npcs do |t|
        t.string :name
        t.string :species
        t.integer :npc_species_id

        t.timestamps
    end
end
end