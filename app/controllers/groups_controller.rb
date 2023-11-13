class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @group = Group.new
  end


  def index
    @groups = Group.paginate(page: params[:page], per_page: 10)
  end

  def show
    @group = Group.find(params[:id])
    @tweets = @group.tweets
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = 'Group created successfully!'
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def join
    @group = Group.find(params[:id])
    current_user.profile.groups << @group
    flash[:success] = 'Joined the group successfully!'
    redirect_to @group
  end

  def leave
    @group = Group.find(params[:id])
    current_user.profile.groups.delete(@group)
    flash[:success] = 'Left the group successfully!'
    redirect_to @group
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
