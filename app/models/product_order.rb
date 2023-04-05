class ProductOrder < ApplicationRecord
    belongs_to :products
    validates :product_quantity, numericality: { greater_thano: 0 }
    validates :product_unit_cost, numericality: { greater_than_or_equal_to: 0 }
end
