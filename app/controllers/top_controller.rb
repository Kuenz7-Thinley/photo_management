class TopController < ApplicationController
  before_action :authenticate_user!
  include AuthHelper

  def index
    # 承認リンクの表示
    @login_url = get_login_url

    # 画像情報
    fetchPosts
  end

  private
    def fetchPosts
      @posts = Post.order(created_at: :desc)
    end
end
