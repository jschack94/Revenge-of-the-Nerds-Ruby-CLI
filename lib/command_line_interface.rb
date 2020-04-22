# ---------------- Required Files ----------------
require "tty-prompt"
require "tty-font"
require 'tty-box'
# ----------------- Constants --------------------
PROMPT = TTY::Prompt.new
CLEAR = "\e[H\e[2J"
# ------------------ Header ----------------------
def header
  font = TTY::Font.new(:starwars)
  pastel = Pastel.new
  puts pastel.blue(font.write("REVENGE OF THE NERDS"))
  puts pastel.green(font.write("WORLD DOMINATION"))
end
# ------------------ Start Here -----------------------
puts CLEAR
def start_screen
  header
  start_choice = PROMPT.select("Choose start to start your adventure") do |option|
  option.choice 'Start', 1
  option.choice 'Exit', 2
  end
  if start_choice == 1
    puts CLEAR
    header
    language_menu
  else
    puts CLEAR
    exit
  end
end

def language_menu
  puts CLEAR
  header
  language_choice = PROMPT.select("Language?") do |option|
    option.choice "English", 1
    option.choice "Korean", 2
    option.choice "Spanish", 3
    option.choice "French", 4
    option.choice "Exit", 5
  end
  if language_choice == 1
    puts CLEAR
    header
    main_menu
  elsif language_choice == 2
    puts CLEAR
    header
    puts "404: 데이터베이스에서 언어 지원을 찾을 수 없으며 향후에는 구현되지 않을 것입니다. 당신은 영어에 붙어 있다고 생각합니다."
    main_menu
  elsif language_choice == 3
    puts CLEAR
    header
    puts "404: Lo sentimos, el soporte de idiomas no se encuentra en nuestras bases de datos y probablemente no se implementará en el futuro. Supongo que estás atrapado con el inglés."
    main_menu
  elsif language_choice == 4
    puts CLEAR
    header
    puts "404: Désolé, le support linguistique n’a pas été trouvé dans nos bases de données et ne sera probablement pas implémenté à l’avenir. Je suppose que vous êtes coincé avec l'anglais"
    main_menu
  elsif language_choice == 5
    puts CLEAR
    exit
  end
end

def return_to_main_menu
  main_menu
end
# ---------------- Main Menu --------------------------------------
def main_menu
  main_menu_choice = PROMPT.select("What would you like to do?") do |option|
    option.choice 'Play Game', 1
    option.choice 'Look Through Past Games', 2
    option.choice 'Instructions', 3
    option.choice 'Delete user and high score', 4
    option.choice 'Exit', 5
  end
  if main_menu_choice == 1
    puts CLEAR
    header
    default_character_or_customize_menu
  elsif main_menu_choice == 2
    puts CLEAR
    header
    past_games
  elsif main_menu_choice == 3
    puts CLEAR
    header
    instructions
  elsif main_menu_choice == 4
    puts CLEAR
    header
    delete_user
  elsif main_menu_choice == 5
    puts CLEAR
    exit
  end
end

def past_games
  Player.find_and_display_by_name
  main_menu
end

def instructions
  puts "Goal: Get your competitor (boss) down to HP 0  before they do the same to you.\nYou will choose be given the option to choose a move once the match has been begun. You can choose either to attack, defend, or play the wildcard. Once you make your selection, the damage (decrease in computer’s HP) and defense (increase in you HP) will be initiated. The strength of an attack as well as the increase in health will be determined by a random number generator between 2 and 4. You can also choose to play the wildcard which will randomly choose between an attack, defense, and miss. If you randomly land on the attack or defense, you will see a greater amount of damage done on your partner. After you choose your move, your computer will automatically go through the exact same actions until we have a winner."

end

def delete_player
  Player.delete_player
  puts "Player deleted."
  return_to_main_menu
end
# --------------- Player --------------------------
def default_character_or_customize_menu
  CLEAR
  header
  default_or_customize_choice = PROMPT.select("Hello there! You are a NERD. Your purpose is to get revenge on all those that have wronged you in your nerdy school days.\nBefore you begin your rampage, please choose if you want to play the game with a default character (nerdiest of nerds) or create your own.") do |option|
    option.choice 'Create character', 1
    option.choice "I'm not creative, please do all the thinking for me.", 2
    option.choice 'Exit',3
  end
  if default_or_customize_choice == 1
    puts CLEAR
    header
    create_character_name
  elsif default_or_customize_choice == 2
    puts CLEAR
    header
    default_character
  elsif
    puts CLEAR
    exit
  end
end

def default_character
  puts "Your name is #{Player.find(1)[:name]}.".upcase
  puts "*"
  puts "*"
  puts "character stats will be randomly generating now..."
  random_stat_assignment
end

def self.random_stat_assignment
  array_keys = [:hp, :iq, :str, :lk]
  base_ch = Player.create(name: "Sheldon", hp: 8, iq: 9, str: 4, lk: 3)
  base_ch_id = base_ch[:id]
    8.times do
      rando = array_keys.sample
    Player.update(base_ch_id, rando => (Player.last[rando] + 1))
  end
  box = TTY::Box.frame "Here is your Character, and the randomly generating stats!", "NAME: #{base_ch[:name]}", "HP: #{Player.last[:hp]}", "IQ: #{Player.last[:iq]}", "STR: #{Player.last[:str]}", "LK: #{Player.last[:lk]}", "You now have a character and finalized stats.", padding: 3, align: :center
  print box
  # puts "Here is your Character, and the randomly generating stats!"
  # puts "NAME: #{base_ch[:name]}"
  # puts "HP: #{Player.last[:hp]}"
  # puts "IQ: #{Player.last[:iq]}"
  # puts "STR: #{Player.last[:str]}"
  # puts "LK: #{Player.last[:lk]}"
  # puts "You now have a character and finalized stats."
  character_skills_menu
end

def create_character_name
  CLEAR
  header
  "You have chosen to create your own nerd."
  name = PROMPT.ask("Please enter your name.", default: "Sheldon")
  Player.create(name: name, hp: 8, iq: 9, str: 4, lk: 3)
  puts "Congrats, #{name} the nerd has been created!"
  manual_stat_assignment
end

def manual_stat_assignment
  puts "Your nerd now needs his stats assigned to him. Please divide his stats between HP, IQ, STR, and LK:"
  array_keys = [:hp, :iq, :str, :lk]
  i = 8
  box = TTY::Box.frame "Here is your player, and his default base stats:", "NAME: #{Player.last[:name]}", "HP: #{Player.last[:hp]}", "IQ: #{Player.last[:iq]}", "STR: #{Player.last[:str]}", "LK: #{Player.last[:lk]}", padding: 3, align: :center
  print box
  # puts "Here is your player, and his default base stats:"
  # puts "NAME: #{Player.last[:name]}"
  # puts "HP: #{Player.last[:hp]}"
  # puts "IQ: #{Player.last[:iq]}"
  # puts "STR: #{Player.last[:str]}"
  # puts "LK: #{Player.last[:lk]}"

  id_num = Player.last[:id]
  8.times do
    stat_choice = PROMPT.select("You have 8 points in total. Please choose the stat that you want to increase by one.") do |option|
    option.choice "HP", 1
    option.choice "IQ", 2
    option.choice "STR", 3
    option.choice "LK", 4
  end
  if stat_choice == 1
    Player.update(id_num, :hp => (Player.last[:hp] + 1))
  elsif stat_choice == 2
    Player.update(id_num, :iq => (Player.last[:iq] + 1))
  elsif stat_choice == 3
    Player.update(id_num, :str => (Player.last[:str] + 1))
  elsif stat_choice == 4
    Player.update(id_num, :lk => (Player.last[:lk] + 1))
  end
  end
  box = TTY::Box.frame "These are your current stats!", "HP: #{Player.last[:hp]}", "IQ: #{Player.last[:iq]}", "STR: #{Player.last[:str]}", "LK: #{Player.last[:lk]}", padding: 3, align: :center
  print box
  # puts "These are your current stats!"
  # puts "HP: #{Player.last[:hp]}"
  # puts "IQ: #{Player.last[:iq]}"
  # puts "STR: #{Player.last[:str]}"
  # puts "LK: #{Player.last[:lk]}"
  character_skills_menu
end

# def character_name
#   PROMPT.ask("Hello there! You are a NERD. Your purpose is to get revenge on all those that have wronged you in your nerdy school days. Before you can start your adventure, please input your name.", default: "Sheldon")
#   character_skills_menu
# end

def character_skills_menu
  character_skills_choice = PROMPT.select("Would you like to customize your skills or choose default?") do |option|
    option.choice "Customize", 1
    option.choice "I'm not creative, please do all the thinking for me.", 2
    option.choice "Exit", 3
  end
  if character_skills_choice == 1
    puts CLEAR
    header
    skills_creation_menu
  elsif character_skills_choice == 2
    puts CLEAR
    header
    box = TTY::Box.frame "Your default skills are:", "Lab Experiment", "Fetal Position", "I'm rubber", "You're glue!", padding: 3, align: :center
    print box
    # puts "Your default skills are: Lab Experiment\nFetal Position\nI'm rubber\nYou're glue!"
    battle_menu
  elsif character_skills_choice == 3
    puts CLEAR
    exit
  end
end

def skills_creation_menu
  puts CLEAR
  header
  custom_skills = PROMPT.collect do
    key(:attack).ask('What would you like to call your attack skill?', required: true)
    key(:defense).ask('What would you like to call your defense skill?', require: true)
    key(:wildcard).ask('What would you like to call your wildcard?', required: true)
  end
  puts custom_skills
  battle_menu
end

# def character_stats_menu
#   character_stats_choice = PROMPT.select("Would you like assign your stats or choose default") do |option|
#     option.choice 'Assign my candies', 1
#     option.choice "I'm still too scared to do anything on my own 😭", 2
#     option.choice 'Exit', 3
#   end
#   if character_stats_choice == 1
#     puts CLEAR
#     header
#     stats_assignment_menu
#   elsif character_stats_choice == 2
#     puts CLEAR
#     header
#     character_review_menu
#   elsif
#     character_stats_choice == 3
#     puts CLEAR
#     exit
#   end
# end

# def stats_assignment_menu
#   # S O S
# end

# def character_review_menu(character_name, character_skills, character_stats)
#   # for later
# end
# ---------------- Battle ----------------------------------------
def battle_menu
  box = TTY::Box.frame "For the longest time.", "Nerds have been at the bottom of the food chain.", "Constantly bullied and picked on by the elite members of society.", "Now, every nerd has come together, and decided that enough is enough.", "It your time to battle those that have picked on you for your entire life.", "Will you seize the opportunity and rise above or keep playing DnD in your mom's basement?", "Your first battle begins now!", padding: 3, align: :center
  print box
  ready_set_go = PROMPT.select("Choose 'NERD LEVEL UP!!' if you will rise to the occasion... Choose 'but DnD is still cool...' if you won't..") do |option|
    option.choice "NERD LEVEL UP!!", 1
    option.choice "but DnD is still cool...", 2
  end
  if ready_set_go == 1
    puts CLEAR
    header
    battle_begin_prompt
  else ready_set_go == 2
    CLEAR
    font = TTY::Font.new(:starwars)
    pastel = Pastel.new
    puts pastel.red(font.write("Not an option NERD"))
    battle_menu
    # battle_begin_prompt
  end
end

  def start_battle
    boss_object = Npc.choose_a_boss
    boss_name = boss_object[:name]
    boss_species = boss_object[:species]
    boss_id = boss_object[:npc_species_id]
    boss_stats_moves_object = NpcSpecie.find(boss_id)
    font = TTY::Font.new(:starwars)
    pastel = Pastel.new
    puts pastel.red(font.write("GET READY!"))
    puts "#{Player.last[:name]}, NERD VS #{boss_name}, #{boss_species}"
    Battle.battle_begins
    main_menu
  end

  def battle_begin_prompt
    battle_begin = PROMPT.select("Press ENTER to begin the battle!") do |option|
      option.choice 'ENTER', 1
      option.choice 'Return to Main Menu'
    end
    if battle_begin == 1
      start_battle
    elsif battle_begin == 2
      return_to_main_menu
    end
  end