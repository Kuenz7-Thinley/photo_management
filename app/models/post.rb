class Post < ApplicationRecord
  has_one_attached :image

  validates_presence_of :title, :message => 'タイトルを入力してください'
  validates_presence_of :image, :message => "画像ファイルを入力しください"
end
