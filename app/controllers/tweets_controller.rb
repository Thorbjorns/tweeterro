class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @tweets = Tweet.paginate(page: params[:page], per_page: 10)
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def new
    @tweet = current_user.profile.tweets.build
    @tweet.parent_tweet_id = params[:parent_tweet_id]
  end

  def create
    @tweet = current_user.profile.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = 'Tweet created successfully!'
      redirect_to tweets_path
    else
      render 'new'
    end
  end


  def reply
    parent_tweet = Tweet.find(params[:id])
    @tweet = current_user.profile.tweets.build(content: params[:content], parent_tweet: parent_tweet)
    if @tweet.save
      flash[:success] = "Reply posted successfully!"
      redirect_back(fallback_location: tweets_path)
    else
      flash[:error] = "Error posting reply."
      redirect_back(fallback_location: tweets_path)
    end
  end

  def destroy
    @tweet = current_user.profile.tweets.find(params[:id])
    if @tweet.destroy
      flash[:success] = "Tweet deleted successfully!"
    else
      flash[:error] = "Error deleting tweet."
    end
    redirect_to tweets_path
  end


  private
  def tweet_params
    params.require(:tweet).permit(:content, :parent_tweet_id, :group_id)
  end

end
