class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    #cart = Cart.find(...)
    #puts "This cart has #{cart.line_items.count} line items"
end

