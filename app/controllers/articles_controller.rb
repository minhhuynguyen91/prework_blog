class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  #impressionist :actions => [:show,:index]
  impressionist


  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    if params[:search]
      @articles = Article.search(params[:search])
      if @articles.blank?
        @articles = Article.tagged_with(params[:search])
      end

    else 
      @articles = Article.all
      #@articles = Article.tagged_with(params[:tag_name])
    end



    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    impressionist(@article) 

    if @article.impressionist_count == nil

      @article.page_view = 0
    else

      @article.page_view = @article.impressionist_count

    end

    @article.save
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    
    respond_to do |format|
      if params[:preview_button]
        format.html { render :new }
      else
        if @article.save
          format.html { redirect_to @article, notice: 'Article was successfully created.' }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { render :new }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    
    @article = Article.find(params[:id])
    @article.attributes = article_params

    respond_to do |format|
      if params[:preview_button]
        format.html { render :edit }
      else
        if @article.save
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :tag_list)
    end
end
