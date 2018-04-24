class MembersController < ApplicationController
  def create
#    @member = Gr.new(group_params)
#    people = params[:people][:count]
    @group = Group.find(params[:groupnumber])
    @role = @group.role
    member_count = @group.members.count
#    if @group.save
    
    if member_count == 0
      people = params[:people][:count]
      people.to_i.times do |n|
        number = n + 1
        member_name  = @group.group_name + '-' + number.to_s
        password = @group.group_name + '-' + number.to_s
        @group.members.create!(
              number: number,
              member_name:  member_name,
              password:              password,
              password_confirmation: password)
      end
    else
      number = @group.members.maximum(:number) + 1
      member_name  = @group.group_name + '-' + number.to_s
        password = @group.group_name + '-' + number.to_s
        @group.members.create!(
              number: number,
              member_name:  member_name,
              password:              password,
              password_confirmation: password)
    end
      
      flash[:success] = "グループを登録しました。"
      redirect_to @group
#    else
#      flash.now[:danger] = "グループの登録に失敗しました。"
#      render :new
#    end
  end
  
  def show
    @group = Group.find(params[:id])
    @members = @group.members.order("number ASC").page(params[:page])
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @group = @member.group
    @role = @group.role
    
    if @member.update(member_params)
      @group = @member.group
      flash[:success] = "メンバー情報を変更しました。"
      redirect_to @group
    else
      flash.now[:danger] = "メンバー情報は変更できませんでした。"
      render :edit
    end
  end

  def destroy
    @member = Member.find_by(id: params[:member_id])
    @member.destroy
    flash[:success] = "メンバーを削除しました。"
    redirect_back(fallback_location: roles_path)
  end

  def edit
    @member = Member.find(params[:id])
    @group = @member.group
    @role = @group.role
  end
  
  private
  
  def member_params
    params.require(:member).permit(:member_name, :password, :password_confirmation)
  end
  
end
