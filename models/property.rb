class Property
    attr_accessor :name, :price, :colour, :type, :owner

    def initialize(name, price, colour, type)
        @name = name
        @price = price
        @colour = colour
        @type = type
        @owner = nil
    end

    def is_available
        @owner.nil? # Check if Property has owner
    end

    def display_info
        owner_status = is_available ? "Available" : "Owned by #{@owner.name}"
        puts "Property Name: #{@name}, Price: $#{@price}, Colour: #{@colour}, Type: #{@type}, Status: #{owner_status}"
    end
end
