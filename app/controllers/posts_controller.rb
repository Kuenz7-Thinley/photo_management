class PostsController < ApplicationController
  before_action :authenticate_user!
  include TweetHelper

  def new
    @post = Post.new
  end

  # 新規画像作成
  def create
    ActiveRecord::Base.transaction do
      post = Post.new(post_params)
      post.save

      if post.errors.any?
        flash[:alert] = post.errors
        redirect_to new_post_path
      else
        redirect_to root_path
      end
    rescue StandardError => e
      Rails.logger.warn e.inspect
      redirect_to new_post_path
      flash[:alert] = 'エラーが発生しました'
      raise ActiveRecord::Rollback
    end
  end

  # 外部URLへツイートする
  def tweet
    ActiveRecord::Base.transaction do
      post_tweet
    rescue StandardError => e
      Rails.logger.warn e.inspect
      # render :new
      flash[:alert] = 'エラーが発生しました'
      raise ActiveRecord::Rollback
    end
  end

  private
    def post_params
      params[:post].permit(
        :title,
        :image
      )
    end
end
