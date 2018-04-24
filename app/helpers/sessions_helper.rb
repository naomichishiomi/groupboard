module SessionsHelper
  def current_group
    @current_group ||= Group.find_by(id: session[:group_id])
  end
  
  def logged_in_group?
    !!current_group
  end

  def current_member
    @current_member ||= Member.find_by(id: session[:member_id])
  end
  
  def logged_in_member?
    !!current_member
  end
end
