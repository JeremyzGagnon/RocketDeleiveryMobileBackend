class Employee < ApplicationRecord
    belongs_to :address
    belongs_to :users

end
