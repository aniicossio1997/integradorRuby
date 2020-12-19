require "active_support/concern"

module MyMixin
  extend ActiveSupport::Concern

  def redirect_if_user_auth
    if user_signed_in?
      redirect_to logged_in_root_path
    else
      redirect_to root_path
    end
  end
end