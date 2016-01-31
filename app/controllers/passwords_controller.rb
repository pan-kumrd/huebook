class PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_authenticity_token
end
