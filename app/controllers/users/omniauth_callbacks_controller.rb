# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      handle_auth "Google"
    end

    def github
      handle_auth "Github"
    end

    def facebook
      handle_auth "Facebook"
    end

    def failure
      redirect_to root_path, alert: "We were unable to authenticate you using your selected provider. Please try again"
    end

    private

    def handle_auth(kind)
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: kind
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{kind.downcase}_data"] = request.env["omniauth.auth"].except("extra") # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end
  end
end
