require_relative './models/player'
require_relative './models/property'
require_relative './controller/monopoly_controller'

@monopoly_game = MonopolyController.new

@players = [
    Player.new("Peter", 16),
    Player.new("Billy", 16),
    Player.new("Charlotte", 16),
    Player.new("Sweedal", 16),
]

def load_game
    @players.each do |player|
        @monopoly_game.add_player(player.name, player.money)
    end
    
    @monopoly_game.load_board("board.json")
    
    @monopoly_game.display_game_state
end

def load_rolls(file_path)
    json_data = File.read(file_path)
    rolls_data = JSON.parse(json_data, symbolize_names: true)

    puts "Rolls loaded successfully from #{file_path}!"

    rolls_data.each_with_index do |roll, index|
        @monopoly_game.play_turn(@monopoly_game.players[index % 4], roll)
    end
end

load_game
load_rolls("rolls_1.json")
@monopoly_game.display_game_state
@monopoly_game.declare_winner
@monopoly_game.reset_game

load_game
load_rolls("rolls_2.json")
@monopoly_game.display_game_state
@monopoly_game.declare_winner
@monopoly_game.reset_game
