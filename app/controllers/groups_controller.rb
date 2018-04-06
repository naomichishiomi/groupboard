class GroupsController < ApplicationController
  def index
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    
    if @group.save
      flash[:success] = "グループを登録しました。"
      redirect_to @group
    else
      flash.now[:danger] = "グループの登録に失敗しました。"
      render :new
    end
  end
  
  private
  
  def group_params
    prams.require(:group).permit(:group_name, :password, :password_confirmation)
  end
end
