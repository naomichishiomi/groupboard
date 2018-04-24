class SessionsController < ApplicationController
  def new
  end

  def create
#    unless params[:session][:group_name] == nil
#      group_name = params[:session][:group_name]
#      password = params[:session][:password]
#      if login_group(group_name, password)
#        flash[:success] = "ログインに成功しました。"
#        redirect_to @group
#      else
#        flash.now[:danger] = "ログインに失敗しました。"
#        render template: "toppages/index"
#      end
#    else
#      @group = Group.find_by(id: session[:group_id])
      member_name = params[:session][:member_name]
      password = params[:session][:password]
#      group_id = params[:session][:group_id]
      if login_member(member_name, password)#group_id)
        flash[:success] = "ログインに成功しました。"
          if @member.admin == true
            redirect_to controller: "roles", action: 'index'
          else
            redirect_to @group
          end
      
      else
        flash.now[:danger] = "ログインに失敗しました。"
        render template: "toppages/index"
      end
#    end
  end

  def destroy
    session[:group_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  private
  
#  def login_group(group_name, password)
#    @group = Group.find_by(group_name: group_name)
#    if @group && @group.authenticate(password)
#      session[:group_id] = @group.id
#      return true
#    else
#      return false
#    end
#  end
  
  def login_member(member_name, password)#, group_id)
    @member = Member.find_by(member_name: member_name)#, group_id: group_id)
    if @member && @member.authenticate(password)
      session[:member_id] = @member.id
      @group = @member.group
      @role = @group.role
      return true
    else
      return false
    end
  end
  
end