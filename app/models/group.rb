class Group < ApplicationRecord
  validates :name, { presence: true, message: 'Name is required' }
  validates :name, length: { minimum: 2, maximum: 50, message: 'Name must be at least 2 characters and cannot have more than 50 characters' }
  validates :name, { uniqueness: true, message: 'Name must be unique' }
  has_and_belongs_to_many :profiles
  has_many :tweets
end
