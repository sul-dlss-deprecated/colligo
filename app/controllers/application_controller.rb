class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  layout 'blacklight'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :on_home_page, :request_path

  def on_home_page
    request_path[:controller] == 'catalog' && request_path[:action] == 'index' && params[:f].blank? && params[:q].blank? && params[:range].blank?
  end

  def request_path
    Rails.application.routes.recognize_path(request.path)
  end
end
