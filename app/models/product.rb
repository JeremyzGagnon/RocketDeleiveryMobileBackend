class Product < ApplicationRecord
    # belongs_to :restaurants
    # has_many :product_orders
    validates :cost, numericality: { greater_than_or_equal_to: 0 }

end
