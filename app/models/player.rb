require_relative 'npc_specie.rb'
require_relative 'npc.rb'
require_relative 'player_move.rb'
require_relative 'battle.rb'

class Player < ActiveRecord::Base
    has_many :player_moves
    has_many :battles

    # def self.introduction
    #     puts "REVENGE OF THE NERDS"
    #     puts "***"
    #     puts "WORLD DOMINATION"
    #     puts "*"
    #     puts "*"
    #     puts "*"
    #     puts "PRESS ENTER TO CONTINUE"
    #     gets.chomp
    #     puts "Hello there! You are a NERD. Your purpose is to get revenge on all those that have wronged you in your nerdy school days."
    #     puts "Before you begin your rampage, please choose if you want to play the game with a default character (nerdiest of nerds) or create your own."
    #     puts "Input 'Create Character' or 'Default Character'"
    #     i = 0
    #     while i == 0 do
    #         character_choice = gets.chomp.downcase
    #         if character_choice == "create character"
    #             i += 1
    #             self.create_character
    #         elsif character_choice == 'default character'
    #             i += 1
    #             self.default_character
    #         else
    #             puts "that did not match any of the options, please type in your option again."
    #         end
    #     end
    #     puts "Press ENTER if you are ready to continue..."
    #     gets.chomp

    #     puts "You now have a character and finalized stats. Here is your moveset!"
    #     PlayerMove.reads_default_moveset
    #     puts "Press ENTER if you are ready to continue..."
    #     gets.chomp

    #     Battle.gameplay_introduction
    #     puts "Press ENTER if you are ready to continue..."
    #     gets.chomp

    #     Battle.initialize_battle
    # end

    # def self.default_character
    #     puts "Your name is #{Player.find(1)[:name]}.".upcase
    #     puts "*"
    #     puts "*"
    #     puts "character stats will be randomly generating now..."
    #     self.random_stat_assignment
    # end

    # def self.random_stat_assignment
    #     array_keys = [:hp, :iq, :str, :lk]
    #     i = 8
    #     base_ch = Player.create(name: "Sheldon", hp: 8, iq: 9, str: 4, lk: 3)
    #     base_ch_id = base_ch[:id]
    #     while i != 0
    #         rando = array_keys.sample
    #         Player.update(base_ch_id, rando => (Player.last[rando] + 1))
    #         i -= 1
    #     end
    #     puts "Here is your Character, and the randomly generating stats!"
    #     puts "NAME: #{base_ch[:name]}}"
    #     puts "HP: #{Player.last[:hp]}}"
    #     puts "IQ: #{Player.last[:iq]}}"
    #     puts "STR: #{Player.last[:str]}}"
    #     puts "LK: #{Player.last[:lk]}}"
    # end


    # def self.create_character
    #     puts "You have chosen to create your own nerd. Please enter your name below:"
    #     name = gets.chomp
    #     Player.create(name: name, hp: 8, iq: 9, str: 4, lk: 3)
    #     puts "Congrats, #{name} the nerd has been created!"
    #     Player.manual_stat_assignment

    # end

    # def self.manual_stat_assignment
    #     puts "Your nerd now needs his stats assigned to him. Please divide his stats between HP, IQ, STR, and LK:"
    #     array_keys = [:hp, :iq, :str, :lk]
    #     i = 8
    #     puts "Here is your player, and his default base stats"
    #     puts "NAME: #{Player.last[:name]}"
    #     puts "HP: #{Player.last[:hp]}"
    #     puts "IQ: #{Player.last[:iq]}"
    #     puts "STR: #{Player.last[:str]}"
    #     puts "LK: #{Player.last[:lk]}"

    #     id_num = Player.last[:id]
    #     while i != 0
    #     puts "You have #{i} points. Please type out the stat that you want to increase by one"
    #     puts "These are your current stats!"
    #     puts "HP: #{Player.last[:hp]}"
    #     puts "IQ: #{Player.last[:iq]}"
    #     puts "STR: #{Player.last[:str]}"
    #     puts "LK: #{Player.last[:lk]}"
    #     stat_input = gets.chomp.downcase
    #     # binding.pry
    #     if stat_input == "hp"
    #         Player.update(id_num, :hp => (Player.last[:hp] + 1))
    #     elsif stat_input == "iq"
    #         Player.update(id_num, :iq => (Player.last[:iq] + 1))
    #     elsif stat_input == "str"
    #         Player.update(id_num, :str => (Player.last[:str] + 1))
    #     elsif stat_input == "lk"
    #         Player.update(id_num, :lk => (Player.last[:lk] + 1))
    #     else
    #         puts "An improper value was typed. Please try again."
    #         i += 1
    #     end
    #      i -= 1
    #     end
    # end

    def self.delete_player(name)
        player = self.find_by(name: name)
        player.destroy
    end

    def self.find_by_name(name)
        self.find_by(name: name)
    end

    def self.display_all_names
        self.all.map {|player| player.name }
    end

    def self.find_and_display_by_name(name)
        self.find_by_name(name)
        puts "#{self.name}"
    end
end