# frozen_string_literal: true

module Users
  # this is RegistrationsController
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name
                                                                  last_name
                                                                  avatar
                                                                  password
                                                                  password_confirmation
                                                                  current_password])
    end

    def update_resource(resource, params)
      if resource.provider == 'google_oauth2'
        params.delete('current_password')
        resource.password = params['password']

        resource.update_without_password(params)
      else
        resource.update_with_password(params)
      end
    end
  end
end
