class TopsController < ApplicationController

    before_action :authenticate_user!

    def index
        if current_user.start_number == 0 then
            redirect_to edit_user_registration_path
        else
            redirect_to meetings_path
        end
    end

end
