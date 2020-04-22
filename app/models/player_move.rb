require_relative 'npc_specie.rb'
require_relative 'npc.rb'
require_relative 'battle.rb'
require_relative 'player.rb'

class PlayerMove < ActiveRecord::Base
    belongs_to :player

    def self.reads_default_moveset
        puts "Your ATTACK move is #{PlayerMove.find(1)[:attack]}"
        puts "*"
        puts "Your DEFENSE move is #{PlayerMove.find(1)[:defense]}"
        puts "*"
        puts "Your WILDCARD move is #{PlayerMove.find(1)[:wildcard]}"
        puts "*"
    end

end