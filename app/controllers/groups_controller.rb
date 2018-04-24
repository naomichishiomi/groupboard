class GroupsController < ApplicationController
  #before_action :require_group_logged_in, only:[:index, :show]
  
  def index
    if logged_in_member?
      @member = current_member
      @group = @member.group #Group.find(params[:id])
      @role = @group.role
      @members = @group.members.order("number ASC").page(params[:page])
      @groups = @role.groups.order("id ASC").page(params[:page])
      @comment = current_member.comments.build
#     @comments = @member.comments.order('created_at DESC').page(params[:page])
      @comments = Comment.where(groupnumber: @group.id).order('created_at DESC').page(params[:page])
    end
  end

  def show
    if current_member.admin == true
      @member = Member.new
    elsif current_member.admin == false
      @member = current_member
    end
    
    @group = Group.find(params[:id])
    @role = @group.role
    @members = @group.members.order("number ASC").page(params[:page])
    @groups = @role.groups.order("id ASC").page(params[:page])
    @comment = current_member.comments.build
#   @comments = @member.comments.order('created_at DESC').page(params[:page])
    @comments = Comment.where(groupnumber: @group.id).order('created_at DESC').page(params[:page])
  end

  def new
    @group = Group.new
  end
  
  def update
    @group = Group.find(params[:id])
    @role = @group.role
    @member = Member.new
    @members = @group.members.order("number ASC").page(params[:page])
    @groups = @role.groups.order("id ASC").page(params[:page])
    @comment = current_member.comments.build
#   @comments = @member.comments.order('created_at DESC').page(params[:page])
    @comments = Comment.where(groupnumber: @group.id).order('created_at DESC').page(params[:page])
    
    if @group.update(group_params)
      flash[:success] = "グループ名は変更されました。"
      redirect_to @group
    else
      flash.now[:danger] = "グループ名は変更できませんでした。"
      render :show
    end
  end

  def create
    @role = Role.find(params[:role_number])
#    @group = Group.new(group_params)
#    people = params[:people][:count]

      number = @role.groups.maximum(:id) + 1
        group_name  = @role.name + '-' + "group" + number.to_s
        @role.groups.create!(
              group_name:  group_name)
    
#    if @group.save
      
#      people.to_i.times do |n|
#        number = n + 1
#        member_name  = @group.group_name + '-' + number.to_s
#        password = @group.group_name + '-' + number.to_s
#        @group.members.create!(
#              number: number,
#              member_name:  member_name,
#              password:              password,
#              password_confirmation: password)
#      end
      flash[:success] = "グループを登録しました。"
      redirect_to roles_path
#    else
#      flash.now[:danger] = "グループの登録に失敗しました。"
#      render :new
#    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = "グループを削除しました。"
    redirect_back(fallback_location: roles_path)
    
  end
  
  private
  
  def group_params
    params.require(:group).permit(:group_name)#, :password, :password_confirmation)
  end
end
