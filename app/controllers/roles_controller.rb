class RolesController < ApplicationController
  def new
    @role = Role.new
    @form = AdminForm.new
  end

  def create
#    @role = Role.new(role_params)
#    mass = params[:mass][:count]
#    admin_name = params[:admin_name][:name]
#    admin_pass = params[:admin_pass][:password]
    
    @form = AdminForm.new(form_params)
    if @form.valid?
      @role = Role.new(name: @form.name)
      mass = @form.count
      admin_name = @form.admin_name
      admin_pass = @form.password  
    
      if @role.save
      
        @role.groups.create(group_name: @role.name + '-' +  "admin")
      
        @group = Group.find_by(group_name: @role.name + '-' +  "admin")
        @group.members.create!(
              number: 0,
              member_name:  @role.name + '-' +  admin_name,
              password:              admin_pass,
              password_confirmation: admin_pass,
              admin:true
              )

      
        mass.to_i.times do |n|
          number = n + 1
          group_name  = @role.name + '-' + "group" + number.to_s
          @role.groups.create!(
                group_name:  group_name)
        end
        flash[:success] = "グループを登録しました。管理者名と管理 パスワードでログインしてください。"
        redirect_to controller: "toppages", action: 'index'
      else
        flash.now[:danger] = "すでに使われているrole名です。変更してください。"
        render :new
      end
      
    else
      render :new
    end  
  end

  def show
    if logged_in_member?
      @member = current_member
      @group = @member.group #Group.find(params[:id])
      @role = @group.role
      @groups = @role.groups.order("id ASC").page(params[:page])
    end
  end

  def index
    if logged_in_member?
      @member = current_member
      @group = @member.group #Group.find(params[:id])
      @role = @group.role
      @groups = @role.groups.order("id ASC").page(params[:page])
    end
      
  end
  
  private
  
  def role_params
    params.require(:role).permit(:name)#, :password, :password_confirmation)
  end
  
  def form_params
    params.require(:admin_form).permit(:name, :count, :admin_name, :password)#, :password, :password_confirmation)
  end
  
end
