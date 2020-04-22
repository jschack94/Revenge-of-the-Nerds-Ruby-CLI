require_relative 'battle.rb'
require_relative 'npc.rb'
require_relative 'player_move.rb'
require_relative 'player.rb'

class NpcSpecie < ActiveRecord::Base
    has_many :npcs
end