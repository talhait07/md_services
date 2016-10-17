class PasswordResetForm
  include Soulless.model

  inherit_from(User, only: [:password],
                     additional_attributes: :password,
                     validate_password_on: :create)

  validates :password, presence: true,
                       confirmation: true
end
