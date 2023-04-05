class User < ApplicationRecord
  # has_many :restaurants
  # has_one :employees
  # has_one :customers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :registerable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable


end
