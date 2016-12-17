class CommentsController < ApplicationController

  def new
    @comments = Comment.new
  end

  def create
    @article  = Article.find(params[:article_id])
    @comments = Comment.new(comment_params)
    respond_to do |format|
      format.html
      format.json
    end
    
    @comments.save

    redirect_to @article
  end

  
  private
    def comment_params
      params.require(:comment).permit(:name, :content, :source_type, :source_id)
    end
end
