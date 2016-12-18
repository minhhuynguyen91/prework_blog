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

  def show
    #@comments = Comment.where({:source_id => params[:source_id], :source_type => params[:source_type]})
  end

  def index
    @comments = Comment.where({:source_id => params[:article_id], :source_type => "Article"})
  end

  
  private
    def comment_params
      params.require(:comment).permit(:name, :content, :source_type, :source_id)
    end
end
