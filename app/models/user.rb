class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username, :message => 'ユーザーIDを入力してください'
  validates_presence_of :password, :message => "パスワードを入力しください"
end
