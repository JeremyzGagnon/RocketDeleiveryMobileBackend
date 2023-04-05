class Order < ApplicationRecord
    # belongs_to :restaurants
    # belongs_to :customers
    # has_many :product_orders
    # has_one :order_statuses
    validates :restaurant_rating, inclusion: { in: [1, 2, 3, 4, 5] }

end
