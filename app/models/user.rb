class User < ApplicationRecord
  validates :email, { presence: true, message: 'Email is required' }
  validates :email, { uniqueness: true, message: 'Email is not unique' }
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'Email address must have email format' }
  validates :encrypted_password, { presence: true, message: 'Password is required' }
  validates :encrypted_password, { minimum: 6, maximum: 8, message: 'Password must be at least 6 characters and cannot have more than 8 characters' }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, inverse_of: :user

  accepts_nested_attributes_for :profile

  after_create :create_user_profile

  private

  def create_user_profile
    Rails.logger.debug("=== Create User Profile Params ===")

    profile_params = profile || {}

    existing_profile = profile

    if existing_profile
      existing_profile.update(username: profile_params[:username], bio: profile_params[:bio])
      Rails.logger.debug("=== Profile successfully updated ===")
    else
      new_profile = build_profile(username: profile_params[:username], bio: profile_params[:bio])

      if new_profile.save
        Rails.logger.debug("=== Profile successfully saved ===")
      else
        Rails.logger.error("=== Error saving profile ===")
        Rails.logger.error(new_profile.errors.full_messages.inspect)
      end
    end
  end
end
