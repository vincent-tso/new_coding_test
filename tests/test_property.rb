require_relative '../models/property.rb'
require_relative '../models/player.rb'

test_property = Property.new("Test", 20, "Red", "Testing")
test_player = Player.new("Vincent Tso", 20)

puts test_property.is_available # true

test_property.owner = test_player

puts test_property.is_available # false

puts test_property.owner.name # "Vincent Tso"

test_property.display_info # Property Name: Test, Price: $20, Colour: Red, Type: Testing, Status: Owned by Vincent Tso

