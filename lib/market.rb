class Market
    attr_reader :name, :vendors

    def initialize(name)
        @name = name
        @vendors = []
    end

    def add_vendor(vendor)
        @vendors << vendor
    end

    def vendor_names
        @vendors.map do |vendor|
            vendor.name
        end
    end

    def vendors_that_sell(item)
        @vendors.select do |vendor|
            vendor.inventory.key?(item)
        end
    end

    def total_inventory
        inventory_hash = {} #Creates an empty hash to store stock across all vendors

        @vendors.each do |vendor| #Iterate through each vendor in the vendor array
            vendor.inventory.each do |item, quantity| #For each vendor, iterate through each vendors inventory hash
                if inventory_hash[item] #checks if item already exists
                    inventory_hash[item][:quantity] += quantity #Adds vendors stock of the item to the quantity count
                    inventory_hash[item][:vendors] << vendor #Adds the current vendor to the vendors array
                else
                    inventory_hash[item] = {quantity: quantity, vendors: [vendor]}
                end
            end
        end

        inventory_hash #return the final inventory hash
    end
end