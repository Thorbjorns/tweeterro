class Profile < ApplicationRecord
  belongs_to :user
  has_many :tweets
  has_and_belongs_to_many :groups

  def in_group?(group)
    groups.exists?(group.id)
  end

end
