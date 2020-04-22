require_relative 'npc_specie.rb'
require_relative 'npc.rb'
require_relative 'player_move.rb'
require_relative 'player.rb'


class Battle < ActiveRecord::Base
    belongs_to :player
    belongs_to :npc
    
    def self.gameplay_introduction
        puts "For the longest time. Nerds have been at the bottom of the food chain. Constantly bullied and picked on by the elite members of society. Now, every nerd has come together, and decided that enough is enough. It your time to battle those that have picked on you for your entire life. Will you seize the opportunity and rise above or keep playing DnD in your mom's basement? Your first battle begins now!"

        puts "**"
        puts "**"
        puts "**"
        puts "Type 'NERD POWER' if you will rise to the occasion... Type 'but DnD is still cool' if you won't.."
        puts "**"
        puts "**"
        
        i = 1
        while i != 0 do
            answer = gets.chomp.downcase
            if answer == 'nerd power'
                puts "Good choice NERD!"
                i -= 1
            elsif answer == 'but DnD is still cool'.downcase
                puts "Not an option NERD"
            else
              puts "I thought you were a NERD...? Type the correct answer NOW"
            end
        end
    end

    def self.initialize_battle 
        boss_object = Npc.choose_a_boss
        boss_name = boss_object[:name]
        boss_species = boss_object[:species]
        boss_id = boss_object[:npc_species_id] 
        boss_stats_moves_object = NpcSpecie.find(boss_id)
        
        Npc.create(name: boss_name, species: boss_species, npc_species_id: boss_id)

        puts "press ENTER to begin the battle!"
        puts "*****"
        gets.chomp 

        puts "get ready!"
        puts "#{Player.last[:name]}, NERD VS #{boss_name}, #{boss_species}"

        puts "press ENTER to begin the battle!"
        puts "*****"
        gets.chomp 
    end

    def self.battle_begins
        player_hp = 2
        boss_hp = 2
        player_id = Player.last[:id]
        boss_specie_id = Npc.last[:npc_species_id]

        # binding.pry
        
        while (player_hp > 0) and (boss_hp > 0) do 
            player_id = Player.last[:id]
            player_hp = Player.last[:hp]
            boss_specie_id = Npc.last[:npc_species_id]
            boss_hp = NpcSpecie.find(boss_specie_id)[:hp]
            
            
            puts "YOUR HP IS #{player_hp}!"
            puts "#{Npc.last[:name].upcase} HP is #{boss_hp}!"
            puts "***"
            puts "These are your moves!"
            PlayerMove.reads_default_moveset
            puts "Type 'ATTACK', 'DEFENSE', or 'WILDCARD'"
            move_choice = gets.chomp.downcase
            if move_choice == 'ATTACK'.downcase
                damage = self.attack_calculation
                enemy_effect = self.npc_effect_calculation(boss_specie_id)

                if enemy_effect > 0
                    Player.update(player_id, :hp => (player_hp - enemy_effect))
                    puts "#{Npc.last[:name].upcase} attacked!"
                elsif enemy_effect < 0
                    enemy_effect = enemy_effect * -1
                    NpcSpecie.update(boss_specie_id, :hp => (boss_hp + enemy_effect))
                    puts "#{Npc.last[:name].upcase} defended!"
                elsif enemy_effect == 0
                    puts "#{Npc.last[:name].upcase} has no effect whatsoever..."
                end

                NpcSpecie.update(boss_specie_id, :hp => (boss_hp - damage))
                puts "#{Player.last[:name].upcase} attacked!"
                
            elsif move_choice == 'DEFENSE'.downcase
                heal = self.defense_calculation
                enemy_effect = self.npc_effect_calculation(boss_specie_id)
            
                if enemy_effect > 0
                    Player.update(player_id, :hp => (player_hp - enemy_effect))
                    puts "#{Npc.last[:name].upcase} attacked!"
                elsif enemy_effect < 0
                    enemy_effect = enemy_effect * -1
                    NpcSpecie.update(boss_specie_id, :hp => (boss_hp + enemy_effect))
                    puts "#{Npc.last[:name].upcase} defended!"
                elsif enemy_effect == 0
                    puts "#{Npc.last[:name].upcase} has no effect whatsoever..."
                end

                Player.update(player_id, :hp => (player_hp + heal))
                puts "#{Player.last[:name].upcase} defended!"

            elsif move_choice == "WILDCARD".downcase
                enemy_effect = self.npc_effect_calculation(boss_specie_id)

                if enemy_effect > 0
                    Player.update(player_id, :hp => (player_hp - enemy_effect))
                    puts "#{Npc.last[:name].upcase} attacked!"
                elsif enemy_effect < 0
                    enemy_effect = enemy_effect * -1
                    NpcSpecie.update(boss_specie_id, :hp => (boss_hp + enemy_effect))
                    puts "#{Npc.last[:name].upcase} defended!"
                elsif enemy_effect == 0
                    puts "#{Npc.last[:name].upcase} has no effect whatsoever..."
                end

                self.wildcard_calculation(boss_hp: boss_hp, player_hp: player_hp, boss_specie_id: boss_specie_id)
                # binding.pry
                puts "#{Player.last[:name].upcase} used wildcard! O.o"
            else
            puts "Not a valid choice. Please enter a correct move to use with."
            end
        end

        p self.who_won(player_hp: player_hp, boss_hp: boss_hp)

        self.reset_stats
            
        p "hello..?"

    end

    def self.attack_calculation
        attack_num = Player.last[:iq] + Player.last[:str]
        random_num = rand(2..4)
        damage = attack_num / random_num
        return damage
    end

    def self.defense_calculation
        defense_num = Player.last[:iq] + Player.last[:str]
        random_num = rand(2..4)
        heal = defense_num / random_num
        heal = heal / 2
        return heal
    end

    def self.wildcard_calculation(boss_hp: , player_hp:, boss_specie_id:)
        damage = self.attack_calculation * 2
        heal = self.defense_calculation * 2
        calculation_array = [NpcSpecie.update(boss_specie_id, :hp => (boss_hp - damage)), Player.update(player_id, :hp => (player_hp + heal)), ""]
        return calculation_array.sample
    end

    def self.npc_effect_calculation(specie_id)
        power_num = NpcSpecie.find(specie_id)[:iq] + NpcSpecie.find(specie_id)[:str]
        random_num = rand(2..4)
        power_num = power_num / random_num
        random_num = rand(-1..1)
        power_num = power_num * random_num
        return power_num
    end
    
    def self.who_won(player_hp: , boss_hp:)
        if (player_hp > 0) and (boss_hp <= 0)
            puts "CONGRATULATIONS! NERDS HAVE PREVAILED! REVENGE IS A DISH BEST SERVED COLD!"
            
        elsif (boss_hp > 0) and (player_hp <= 0)
            puts "THE NERDS SPEND ANOTHER DAY IN THE DUMPS.... BETTER LUCK NEXT TIME.... 8_("
        elsif (player_hp <= 0) and (boss_hp <= 0)
            puts "IT'S A DEAD TIE! DEADLOCKED! BUT THIS PROVES THAT NERDS ARE ON EVEN FOOTING NOW! DO YOU DARE TRY FOR MORE...?"
        end
    end

    def self.reset_stats 
        NpcSpecie.update(1, :hp => 8, :iq => 2, :str => 10, :lk => 4)
        NpcSpecie.update(2, :hp => 10, :iq => 10, :str => 4, :lk => 2)
        NpcSpecie.update(3, :hp => 12, :iq => 6, :str => 5, :lk => 8)
    end

    
end