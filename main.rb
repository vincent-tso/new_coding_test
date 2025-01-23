require_relative './models/player'
require_relative './models/property'
require_relative './controller/monopoly_controller'

# Initiate variables
STARTING_MONEY = 16

monopoly_game = MonopolyController.new

players = [
    ["Peter", STARTING_MONEY],
    ["Billy", STARTING_MONEY],
    ["Charlotte", STARTING_MONEY],
    ["Sweedal", STARTING_MONEY],
]

# Load board.json file
def load_game(players, monopoly_game)
    players.each do |player|
        monopoly_game.add_player(player[0], player[1])
    end
    
    monopoly_game.load_board("board.json")
    
    monopoly_game.display_game_state
end

# Load rolls_#.json file
def load_rolls(file_path, monopoly_game, players)
    json_data = File.read(file_path)
    rolls_data = JSON.parse(json_data, symbolize_names: true)

    puts "Rolls loaded successfully from #{file_path}!"

    rolls_data.each_with_index do |roll, index|
        monopoly_game.play_turn(monopoly_game.players[index % players.length()], roll)
    end
end

# Run game 1
load_game(players, monopoly_game)
load_rolls("rolls_1.json", monopoly_game, players)
monopoly_game.display_game_state
monopoly_game.declare_winner
monopoly_game.reset_game

# Run game 2
load_game(players, monopoly_game)
load_rolls("rolls_2.json", monopoly_game, players)
monopoly_game.display_game_state
monopoly_game.declare_winner
monopoly_game.reset_game
