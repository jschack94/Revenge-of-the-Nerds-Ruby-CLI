require_relative 'npc_specie.rb'
require_relative 'battle.rb'
require_relative 'player_move.rb'
require_relative 'player.rb'

class Npc < ActiveRecord::Base
    has_one :npc_specie
    has_many :battles
  
    def self.choose_a_boss
        # row_num = 0 
        # self.all.each {row_num += 1}
        rando_num = rand(1..3) # 3 used to be row_num
        return Npc.find(rando_num)
    end
end