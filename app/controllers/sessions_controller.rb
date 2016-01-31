class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token
end

class PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_authenticity_token
end