class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_variables

  def set_variables
    @diagnosis_log_dates = DiagnosisLog.date_list
    @ssid_list = LogCampaign.ssid_list
  end

  # for divise
  def after_sign_in_path_for(resource)
    stored_location_for(:user) || root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u|
      u.permit(:login, :id, :account, :password, :remember_me)
    }
  end
end
