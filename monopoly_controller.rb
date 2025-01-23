class MonopolyController
    attr_reader :players, :properties

    def initialize
        @players = []
        @properties = []
    end

    # Add a player to the game
    def add_player(name, money)
        player = Player.new(name, money)
        @players << player
        puts "#{player.name} has been added to the game with $#{player.money}."
    end

    # Add a property to the game
    def add_property(name, price, colour, type)
        property = Property.new(name, price, colour, type)
        @properties << property
        puts "Property '#{property.name}' has been added to the game."
    end

    # TODO
    # Add functionality to move player
    # Add functionality to handle logic for property management
        # Is property available?
        # Does player require paying rent?
        # Is player bankrupt?

    

end
