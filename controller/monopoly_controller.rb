require 'json'
require_relative '../models/player'
require_relative '../models/property'

class MonopolyController
    attr_reader :players, :properties, :board, :running

    def initialize
        @players = []
        @properties = []
        @board = []
        @running = true
    end

    # Add a player to the game
    def add_player(name, money)
        player = Player.new(name, money)
        @players << player
        puts "#{player.name} has been added to the game with $#{player.money}."
    end

    # Load monopoly board
    def load_board(file_path)
        json_data = File.read(file_path)
        board_data = JSON.parse(json_data, symbolize_names: true)

        board_data.each do |tile|
            case tile[:type]
                when "go"
                    @board << { name: tile[:name], type: tile[:type] }
                when "property"
                    property = Property.new(tile[:name], tile[:price], tile[:colour], tile[:type])
                    @board << property
                    @properties << property
                else
                    puts "Unknown tile type: #{tile[:type]}"
            end
        end

        puts "Board loaded successfully from #{file_path}!"
    end

    # Play a turn for a player
    def play_turn(player, roll)
        if @running
            puts "#{player.name} rolls a #{roll}."
            player.move(roll, @board.length())
            puts "#{player.name} moves to position #{player.position}."
            handle_property(player)
        end
    end

    # Handle player landing on a property
    def handle_property(player)
        if player.position > 0
            property = @properties[player.position - 1]

            if property.is_available
                if player.money >= property.price
                    puts "#{player.name} can buy '#{property.name}' for $#{property.price}."
                    player_properties = properties.select { |p| p.owner == player && p.colour == property.colour }
                    player.money -= property.price
                    property.owner = player
                    puts "#{player.name} bought '#{property.name}'."
                    
                    # Check if player owns full set of property
                    if player_properties.length() > 0
                        puts "#{player.name} owns the full property set. Rent is now double for those properties!"
                        property.price = 2 * property.price
                        player_properties.each { |p| p.price = 2 * p.price }
                    end

                else
                    puts "#{player.name} does not have enough money to buy '#{property.name}'."
                    # End game
                    @running = false
                end
            else
                if property.owner != player
                    puts "#{player.name} landed on '#{property.name}', owned by #{property.owner.name}. Rent is $#{property.price}."
                    
                    if player.money >= property.price
                        player.money -= property.price
                        property.owner.money += property.price
                        puts "#{player.name} paid $#{property.price} to #{property.owner.name}."
                    else
                        puts "#{player.name} cannot afford to pay the rent and is bankrupt!"
                        # End game
                        @running = false
                    end
                else
                    puts "#{player.name} landed on their own property '#{property.name}'."
                end
            end
        end
    end

    # Display game state
    def display_game_state
        puts "Game State:"
        @players.each do |player|
            player.display_info
        end
    end

    # Game over, declare winner
    def declare_winner
        winner = @players.max_by(&:money)
        
        puts "GAME OVER: #{winner.name} has won!"
    end

    # Reset game for new set of rolls
    def reset_game
        @players = []
        @properties = []
        @board = []
        @running = true

        puts "Game has successfully been reset."
    end
end
