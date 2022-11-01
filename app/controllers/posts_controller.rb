class PostsController < ApplicationController
  before_action :authenticate_user!
  include TweetHelper

  def new
    @post = Post.new
  end

  def create
    ActiveRecord::Base.transaction do
      post = Post.new(post_params)
      post.save!

      redirect_to root_path
    rescue StandardError => e
      Rails.logger.warn e.inspect
      render :new
      flash[:alert] = 'エラーが発生しました'
      raise ActiveRecord::Rollback
    end
  end

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
