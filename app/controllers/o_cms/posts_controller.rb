require_dependency "o_cms/application_controller"

module OCms
  class PostsController < ApplicationController

    def index
      @posts = Post.all
    end

    def show
      @post = Post.find(params[:id])
    end

    def new
      @post = Post.new
      @categories = Category.all
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        flash[:notice] = "Post was saved successfully."
        redirect_to edit_post_path(@post)
      else
        flash.now[:alert] = "Error creating post. Please try again."
        render :new
      end
    end

    def edit
      @post = Post.find(params[:id])
      @categories = Category.all
    end

    def update
      @post = Post.find(params[:id])
      @post.assign_attributes(post_params)

      if @post.save
        flash[:notice] = "Post was updated successfully."
        redirect_to edit_post_path(@post)
      else
        flash.now[:alert] = "Error saving post. Please try again."
        render :edit
      end
    end

    def destroy
      @post = Post.find(params[:id])

      if @post.destroy
        flash[:notice] = "\"#{@post.title}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleting the post."
        render :show
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :slug, :body, :excerpt, :featured_image, :meta_title, :meta_description, :meta_keywords, :status, :published_at, :category_ids => [])
    end
  end
end
