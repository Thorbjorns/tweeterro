# app/controllers/replies_controller.rb

class RepliesController < ApplicationController
  before_action :authenticate_user!

  def new
    @reply = Tweet.new(parent_tweet: Tweet.find(params[:tweet_id]))
  end

  def create
    @reply = current_user.profile.tweets.build(tweet_params)
    puts "Parent Tweet ID: #{params[:tweet_id]}"  # Dodaj to do sprawdzenia

    if @reply.save
      flash[:success] = "Reply posted successfully!"
      redirect_to tweets_path
    else
      flash[:error] = "Error posting reply."
      render 'new'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :parent_tweet_id)
  end
end
