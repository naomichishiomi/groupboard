class CommentsController < ApplicationController
  before_action :require_member_logged_in
  
  def create
    @comment = current_member.comments.build(comment_params)
    @member = current_member
    @group = current_member.group
    @role = @group.role
    @comment.groupnumber = params[:groupnumber]
    if @comment.save
      flash[:success] = "コメントを投稿しました。"
      redirect_to @group
    else
      @comment = current_member.comments.order("created_at DESC").page(params[:page])
      flash[:danger] = "コメントの投稿に失敗しました。"
      redirect_to @group
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:comment_id])
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_back(fallback_location: roles_path)
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content, :groupnumber)
  end
end
