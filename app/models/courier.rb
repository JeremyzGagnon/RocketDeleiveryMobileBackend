class Courier < ApplicationRecord
    has_one :courier_status
    belongs_to :order
end
