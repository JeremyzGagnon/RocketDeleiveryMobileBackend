class Restaurant < ApplicationRecord
    belongs_to :address
    has_many :products
    has_many :orders
    validates :price_range, inclusion: { in: [1, 2, 3] }

end

