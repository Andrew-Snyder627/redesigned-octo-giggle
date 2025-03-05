class Item
    attr_reader :name, :price

    def initialize(details)
        @name = details[:name]
        @price = details[:price].delete_prefix("$").to_f #Had to look this up, needs to be a float based on interaction pattern
    end
end