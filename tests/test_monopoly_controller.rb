require_relative '../controller/monopoly_controller.rb'

test_game = MonopolyController.new

test_game.players.each { |player| puts player.name } # Empty

test_game.add_player("Vincent Tso", 20)

test_game.players.each { |player| puts player.name } # Vincent Tso

test_game.display_game_state # Game State:
                             # Player Name: Vincent Tso, Money: $20, Position: 0

test_game.reset_game

test_game.players.each { |player| puts player.name } # Empty
