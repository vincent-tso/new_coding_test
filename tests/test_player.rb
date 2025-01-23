require_relative '../models/player.rb'

test_player = Player.new("Test", 5)

puts test_player.name # "Test"
puts test_player.money # 5

test_player.name = "Vincent Tso"

puts test_player.money == 5 # true
puts test_player.name # "Vincent Tso"

test_player.display_info # Player Name: Vincent Tso, Money: 5, Position: 0
