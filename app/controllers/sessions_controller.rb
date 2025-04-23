class SessionsController < ApplicationController
    # OmniAuthのコールバックに対してはCSRF保護をスキップ
    skip_before_action :verify_authenticity_token, only: :create
    
    def create
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    end
    
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'ログアウトしました'
    end
    
    def failure
      redirect_to root_path, alert: "認証に失敗しました: #{params[:message]}"
    end

    def new
    end
  end