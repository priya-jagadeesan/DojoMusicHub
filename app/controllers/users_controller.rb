class UsersController < ApplicationController
    skip_before_action :require_login, only: [:create]
    before_action :loggedIn, except: [:create, :show]

    def index

    end

    def new

    end

    def create
        if params[:form_value]=='register'
            @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                redirect_to "/songs"
            else
                # flash[:hasError] =  'has-error'
                flash[:register] = @user.errors
                redirect_to "/main"
            end
        elsif params[:form_value]=='sign_in'
            @user = User.find_by(email: params[:email].downcase).try(:authenticate, params[:password])
            if @user
                session[:user_id] = @user.id
                redirect_to "/songs"
            else
                # flash[:has_Error] =  'has-error'
                flash[:sign_in] = '*Invalid Credentials'
                redirect_to "/main"
            end
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private
    def user_params
        params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
    end

end
