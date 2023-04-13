class User < ApplicationRecord
  has_one :customer
  has_one :employee
  has_one :courier
  has_many :restaurants
  validates :name, :email, :password, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Checks if user is an employee when signing in. Automatically picked up by Rails
  def active_for_authentication?
    super && is_employee?
  end

  def is_employee?
    Employee.find_by(id: self.id)
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    return false unless user
    user.authenticate(password)
  end

end
