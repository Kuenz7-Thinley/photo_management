# Rails x kintone OAuth client sample program
# Copyright (c) 201x Cybozu
#
# Licensed under the MIT License
# https://opensource.org/licenses/mit-license.php

module AuthHelper
  # OAuth設定のクライアントID
  CLIENT_ID = 'b7f8811dc9db233939ba39ba620c4d48e2a97e68086c684e15c950ae562e92ec'

  # OAuth設定のクライアントシークレット
  CLIENT_SECRET = '2cca5a88c120843da376668c601aa4a62f76be0448deafc66f2968a924bcb57e'

  # URL
  SITE = 'https://arcane-ravine-29792.herokuapp.com'

  # 認可エンドポイント
  AUTHORIZE_URL = '/oauth/authorize'

  # トークンエンドポイント
  TOKEN_URL = '/oauth/token'

  # APIアクセスのスコープ設定 read/write権限
  SCOPES = ['k:app_record:read','k:app_record:write']

  # CSRF対策のランダムな値
  STATE = SecureRandom.alphanumeric

  # ログインURLの生成
  def get_login_url
    client = OAuth2::Client.new(CLIENT_ID,
                                CLIENT_SECRET,
                                :site => SITE,
                                :authorize_url => AUTHORIZE_URL,
                                :token_url => TOKEN_URL)

    login_url = client.auth_code.authorize_url(:redirect_uri => callback_oauth_index_url) # Railsの認可ページへのルートパス
  end

  # アクセストークン取得のための認可コードを送信
  def get_token_from_code(auth_code)
    client = OAuth2::Client.new(CLIENT_ID,
                                CLIENT_SECRET,
                                :site => SITE,
                                :authorize_url => AUTHORIZE_URL,
                                :token_url => TOKEN_URL)

    token = client.auth_code.get_token(auth_code,
                                        :redirect_uri => callback_oauth_index_url)
  end

  # アクセストークンの取得
  def get_access_token
    # セッションから現在のアクセストークンハッシュを取得
    token_hash = session[:unifa_token]

    client = OAuth2::Client.new(CLIENT_ID,
                                CLIENT_SECRET,
                                :site => SITE,
                                :authorize_url => AUTHORIZE_URL,
                                :token_url => TOKEN_URL)

    token = OAuth2::AccessToken.from_hash(client, token_hash)

    # アクセストークンが期限切れの場合、リフレッシュトークンからアクセストークンを取得
    if token.expired?
      new_token = token.refresh!
      # 新アクセストークンをセッションへ保存
      session[:unifa_token] = new_token.to_hash
      access_token = new_token
    else
      access_token = token
    end
  end
end