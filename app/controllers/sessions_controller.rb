class SessionsController < ApplicationController
  def new
  end

  def create
    user_id  = params[:session][:user_id]
    password = params[:session][:password]

    user = User.find_by(user_id: user_id)
    
    if user && user.authenticate(password)
      log_in user
      redirect_to root_url
    else
      flash[:danger] = []
      flash[:danger] << 'ユーザーIDを入力してください' unless user_id.present?
      flash[:danger] << 'パスワードを入力してください' unless password.present?
      flash[:danger] << 'ユーザーIDとパスワードが一致するユーザーが存在しません' if user_id.present? && password.present?
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
