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
                    inventory_hash[item] = {quantity: quantity, vendors: [vendor]} #sets the quanitity for this item, and creates a vendors array with this vendor
                end
            end
        end

        inventory_hash #return the final inventory hash
    end

    def overstocked_items #going to reuse above hash
        overstocked = []

        total_inventory.each do |item, item_data|
            if item_data[:quantity] > 50 && item_data[:vendors].length > 1
                overstocked << item
            end
        end

        overstocked
    end

    def sorted_item_list
        item_names = []

        @vendors.each do |vendor|
            vendor.inventory.each do |item, quanitity| #Not going to use quantity, could I use _ instead? I did this in my project but would like feedback on when to use it.
                item_names << item.name unless item_names.include?(item.name) #avoiding dupes
            end
        end

        item_names.sort #Sort the array alphabetically.
    end
end