module LoggedOut

  class HomeController < LoggedOutController
    include MyMixin
    before_action :redirect_if_user_auth
    def welcome
    end

  end
end