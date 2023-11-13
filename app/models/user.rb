class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile
  accepts_nested_attributes_for :profile

  after_create :create_user_profile

  private
  def create_user_profile
    create_profile
  end
end
