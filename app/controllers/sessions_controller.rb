class SessionsController < ApplicationController
    def new
    end

    def create
        # check if the user exists
        @user = User.find_by({"email" => params["email"]})
        if @user
            # if the user exists, check if the password is correct
            if BCrypt::Password.new(@user["password"]) == params["password"]
                cookies["monster"] = "me like cookies"
                session["user_id"] = @user["id"]
                # if the password is correct, log the user in
                redirect_to "/companies"
            else
                redirect_to "/sessions/new"
            end
        else
            redirect_to "/sessions/new"
        end
    end

    def destroy
        session["user_id"] = nil
        redirect_to "/sessions/new"
    end
end
