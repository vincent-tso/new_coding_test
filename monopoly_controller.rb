class MonopolyController
    attr_reader :players, :properties, :board

    def initialize
        @players = []
        @properties = []
        @board = []
    end

    # Add a player to the game
    def add_player(name, money)
        player = Player.new(name, money)
        @players << player
        puts "#{player.name} has been added to the game with $#{player.money}."
    end

    # Load monopoly board
    def load_board
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
        puts "#{player.name} rolls a #{roll}."
        player.move(roll, @board.length())
        puts "#{player.name} moves to position #{player.position}."
        handle_property(player)
    end

    # Handle player landing on a property
    def handle_property(player)
        property = @properties[player.position - 1]

        if property.available?
            if player.money >= property.price
                puts "#{player.name} can buy '#{property.name}' for $#{property.price}."
                player.money -= property.price
                property.owner = player
                puts "#{player.name} bought '#{property.name}'."
            else
                puts "#{player.name} does not have enough money to buy '#{property.name}'."
                # TODO
                # End game
            end
        else
            if property.owner != player
                rent = property.rent
                puts "#{player.name} landed on '#{property.name}', owned by #{property.owner.name}. Rent is $#{rent}."
                
                if player.money >= rent
                    player.money -= rent
                    property.owner.money += rent
                    puts "#{player.name} paid $#{rent} to #{property.owner.name}."
                else
                    puts "#{player.name} cannot afford to pay the rent and is bankrupt!"
                    # TODO
                    # End game
                end
            else
                puts "#{player.name} landed on their own property '#{property.name}'."
            end
        end
    end

end
