class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  private
  
  def require_group_logged_in
    unless logged_in_group?
      redirect_to root_url
    end
  end
end
