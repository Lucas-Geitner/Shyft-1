class ProfileController < ApplicationController
    # Controller for user (worker) interface
    # Chat | Planning view | Contract view

    layout "mobile_first"
    def showProfileData
        @user = current_user
    end
end