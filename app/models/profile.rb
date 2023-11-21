class Profile < ApplicationRecord
  validates :bio, { presence: true, message: 'Bio is required' }
  validates :bio, { minimum: 15, maximum: 255, message: 'Bio must be at least 15 characters and cannot have more than 255 characters' }
  validates :username, { minimum: 5, maximum: 50, message: 'Username must be at least 5 characters and cannot have more than 50 characters' }
  validates :username, { uniqueness: true, message: 'Username must be unique' }

  belongs_to :user
  has_many :tweets
  has_and_belongs_to_many :groups

  def in_group?(group)
    groups.exists?(group.id)
  end

end
