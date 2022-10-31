class OauthController < ApplicationController
  before_action :authenticate_user!
  include AuthHelper

  # 認可コードからアクセストークンを取得
  def gettoken
    token = get_token_from_code params[:code]
    session[:unifa_token] = token.to_hash
    redirect_to root_path
  end
end
