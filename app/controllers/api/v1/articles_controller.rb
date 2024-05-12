module Api
  module V1


class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]


  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    if @article.save
      image = params[:article][:image]
      result = Cloudinary::Uploader.upload(image.path)
      @article.update(image_data: result['secure_url'])
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      if params[:article][:image]
        image = params[:article][:image]
        result = Cloudinary::Uploader.upload(image.path)
        @article.update(image_data: result['secure_url'])
      end
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    Cloudinary::Uploader.destroy(@article.image_data)
    @article.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :image)
    end

end
end
end
