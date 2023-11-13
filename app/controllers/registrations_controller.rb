# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:username, :bio])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, profile_attributes: [:username, :bio])
  end
end
