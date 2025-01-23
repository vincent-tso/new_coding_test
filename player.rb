class Player
    attr_accessor :name, :money, :position

    def initialize(name, money)
        @name = name
        @money = money
        @position = 0
    end

    def move(spaces, board_size)
        @position = (@position + spaces) % board_size # Resets to Go after final tile
    end
end
