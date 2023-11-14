class User < ApplicationRecord
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
