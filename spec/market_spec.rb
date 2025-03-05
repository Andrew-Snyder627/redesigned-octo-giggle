require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
    describe '#initialize' do
        it 'exists' do
            market = Market.new("South Pearl Street Farmers Market")

            expect(market).to be_a(Market)
        end

        it 'has attributes' do
            market = Market.new("South Pearl Street Farmers Market")

            expect(market.name).to eq("South Pearl Street Farmers Market")
            expect(market.vendors).to eq([])
        end
    end

    describe '#add_vendor' do
        it 'can add vendors to the market' do
            market = Market.new("South Pearl Street Farmers Market")
            vendor1 = Vendor.new("Rocky Mountain Fresh")
            vendor2 = Vendor.new("Ba-Nom-a-Nom")
            vendor3 = Vendor.new("Palisade Peach Shack")

            market.add_vendor(vendor1)
            market.add_vendor(vendor2)
            market.add_vendor(vendor3)
            
            expect(market.vendors).to eq([vendor1, vendor2, vendor3])
        end
    end

    describe '#vendor_names' do
        it 'can provide vendor names' do
            market = Market.new("South Pearl Street Farmers Market")
            vendor1 = Vendor.new("Rocky Mountain Fresh")
            vendor2 = Vendor.new("Ba-Nom-a-Nom")
            vendor3 = Vendor.new("Palisade Peach Shack")

            market.add_vendor(vendor1)
            market.add_vendor(vendor2)
            market.add_vendor(vendor3)

            expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
        end
    end

    describe '#vendors_that_sell' do
        it 'can find vendors that sell a specific item' do
            market = Market.new("South Pearl Street Farmers Market")

            vendor1 = Vendor.new("Rocky Mountain Fresh")
            vendor2 = Vendor.new("Ba-Nom-a-Nom")
            vendor3 = Vendor.new("Palisade Peach Shack")

            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: "$0.50"})
            item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
            item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

            vendor1.stock(item1, 35)
            vendor1.stock(item2, 7)
            vendor2.stock(item4, 50)
            vendor2.stock(item3, 25)
            vendor3.stock(item1, 65)

            market.add_vendor(vendor1)
            market.add_vendor(vendor2)
            market.add_vendor(vendor3)

            expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
            expect(market.vendors_that_sell(item4)).to eq([vendor2])
        end
    end

    describe '#total_inventory' do
        it 'can calculate total inventory' do
            market = Market.new("South Pearl Street Farmers Market")

            vendor1 = Vendor.new("Rocky Mountain Fresh")
            vendor2 = Vendor.new("Ba-Nom-a-Nom")

            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: "$0.50"})

            vendor1.stock(item1, 35)
            vendor1.stock(item2, 10)
            vendor2.stock(item1, 25)
            vendor2.stock(item2, 20)

            market.add_vendor(vendor1)
            market.add_vendor(vendor2)

            expect(market.total_inventory).to eq({
                item1 => {quantity: 60, vendors: [vendor1, vendor2]},
                item2 => {quantity: 30, vendors: [vendor1, vendor2]}
            })
        end
    end

    describe '#overstocked_items' do
        it 'can correctly identify overstocked items' do
            market = Market.new("South Pearl Street Farmers Market")

            vendor1 = Vendor.new("Rocky Mountain Fresh")
            vendor2 = Vendor.new("Ba-Nom-a-Nom")

            item1 = Item.new({name: 'Peach', price: "$0.75"})

            vendor1.stock(item1, 40)
            vendor2.stock(item1, 20)

            market.add_vendor(vendor1)
            market.add_vendor(vendor2)

            expect(market.overstocked_items).to eq([item1])
        end
    end
end