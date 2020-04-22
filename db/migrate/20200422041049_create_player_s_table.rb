class CreatePlayerSTable < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
        t.string :name
        t.integer :hp
        t.integer :iq
        t.integer :str
        t.integer :lk
        t.string :species

        t.timestamps
    end
end
end