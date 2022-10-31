class SessionsController < ApplicationController
  def new
  end

  def create
    ActiveRecord::Base.transaction do
      user = User.find_by(username: user_params[:username])
      if user.present? && user.authenticate(user_params[:password])
        # Log the user in and redirect to the user's show page.
        log_in user
        redirect_to root_path, notice: 'logged in successfully'
      else
        # Create an error message.
        flash[:alert] = 'メールアドレスまたはパスワードが違います。'
        render :new
      end
    rescue StandardError => e
      Rails.logger.warn e.inspect
      flash[:alert] = 'エラーが発生しました'
      raise ActiveRecord::Rollback
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      session[:user_id] = nil
      redirect_to root_path, notice: 'ログアウトしました。'
    rescue StandardError => e
      Rails.logger.warn e.inspect
      flash[:alert] = 'エラーが発生しました'
      raise ActiveRecord::Rollback
    end
  end

  private
    def user_params
      params[:session].permit(
        :username,
        :password
      )
    end
end
