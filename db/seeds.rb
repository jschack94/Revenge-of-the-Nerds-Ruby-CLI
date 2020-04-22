ActiveRecord::Base.logger = Logger.new(STDOUT)

#player_id, npc_id, player_win
battles_list = [
    [1, 1, nil]
]
battles_list.each do |player_id, npc_id, player_win|
    Battle.create(player_id: player_id, npc_id: npc_id, player_win: player_win)
end

# Npc.create(name: "blop", species: "unshaped", npc_species_id: 1 )
# name, species, npc_species_id
npc_list = [
    ["Chad", "Bully", 1],
    ["Mrs. Karen", "Teacher", 2],
    ["'Mom'", "Evil Step-Mother", 3]
]
npc_list.each do |name, species, npc_species_id|
    Npc.create(name: name, species: species, npc_species_id: npc_species_id)
end

# Npc_specie.create(hp: 10, iq: , str:, lk:, npc_attack:, npc_defense: , ult:  )
#hp, iq, str, lk, npc_attack, npc_defense, ult
npc_species_list = [
    [8, 2, 10, 4, "Wedgie", "'It's just a joke, bro'", "Cry to Mom"],
    [10, 10, 4, 2, "Ruler Smack", "'Well I never'", "Detention!"],
    [12, 6, 5, 8, "Chancla!", "'Because I said so!'", "Bring me your manager!"]
] #[24, 26, 34]
npc_species_list.each do |hp, iq, str, lk, npc_attack, npc_defense, ult|
    NpcSpecie.create(hp: hp, iq: iq, str: str, lk: lk, npc_attack: npc_attack, npc_defense: npc_defense, ult: ult)
end

# attack, defense, wildcard, player_id
player_moves_list = [
    ["Lab Experiment", "Fetal Position", "I'm rubber, and you're glue!"]
] # these are the base moveset, the user will have an option to stick with the stock list, or customize their moves --> will be done by creating a new instance.
player_moves_list.each do |attack, defense, wildcard, player_id|
    PlayerMove.create(attack: attack, defense: defense, wildcard: wildcard, player_id: player_id)
end

# name, species, hp, iq, str, lk
player_list = [
    ["Sheldon","NERD", 8, 9, 4, 3]
] #[24] + 8 = [32] (plus one per boss defeated) Consider adding species column that says NERD
player_list.each do |name, species, hp, iq, str, lk|
    Player.create(name: name, species: species, hp: hp, iq: iq, str: str, lk: lk)
end