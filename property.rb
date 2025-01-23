class Property
    attr_accessor :name. :price, :colour, :type, :owner

    def initialize(name, price, colour, type)
        @name = name
        @price = price
        @colour = colour
        @type = type
        @owner = nil
    end

    def available?
        @owner.nil? # Check if Property has owner
    end
end
