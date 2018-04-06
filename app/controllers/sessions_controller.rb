class SessionsController < ApplicationController
  def new
  end

  def create
    group_name = params[:session][:group_name]
    password = params[:session][:password]
    if login(group_name, password)
      flash[:success] = "ログインに成功しました。"
      redirect_to @group
    else
      flash.now[:danger] = "ログインに失敗しました。"
      render "new"
    end
  end

  def destroy
    session[:group_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  private
  
  def login(group_name, password)
    @group = Group.find_by(group_name: group_name)
    if @group && @group.authenticate(password)
      session[:group_id] = @group.id
      return true
    else
      return false
    end
  end
end
