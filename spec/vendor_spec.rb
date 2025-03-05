require './lib/vendor'

RSpec.describe Vendor do
    describe '#initialize' do
        it 'exists' do
            vendor = Vendor.new("Rocky Mountain Fresh")

            expect(vendor).to be_a(Vendor)
        end

        it 'has attributes' do
            vendor = Vendor.new("Rocky Mountain Fresh")

            expect(vendor.name).to eq("Rocky Mountain Fresh")
            expect(vendor.inventory).to eq({})
        end
    end

    describe '#stock' do
        it 'can stock items' do
            vendor = Vendor.new("Rocky Mountain Fresh")
            item1 = Item.new({name: 'Peach', price: "$0.75"})

            expect(vendor.check_stock(item1)).to eq(0)

            vendor.stock(item1, 30)

            expect(vendor.check_stock(item1)).to eq(30)
        end
    end

    describe '#check_stock' do
        it 'can check the inventory of an item and add items' do
            vendor = Vendor.new("Rocky Mountain Fresh")
            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: '$0.50'})

            expect(vendor.check_stock(item1)).to eq(0)

            vendor.stock(item1, 30)

            expect(vendor.check_stock(item1)).to eq(30)
            expect(vendor.inventory).to eq({item1: => 30})

            vendor.stock(item1, 25)

            expect(vendor.inventory).to eq({item1 => 55})

            vendor.stock(item2, 12)

            expect(vendor.inventory).to eq({item1: 55, item2: 12})
        end
    end
end