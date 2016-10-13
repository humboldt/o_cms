require_dependency "o_cms/application_controller"

module OCms
  class CategoriesController < ApplicationController

    def index
      @categorys = Category.all
    end

    def show
      @category = Category.find(params[:id])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        flash[:notice] = "Category was saved successfully."
        redirect_to edit_category_path(@category)
      else
        flash.now[:alert] = "Error creating category. Please try again."
        render :new
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])
      @category.assign_attributes(category_params)

      if @category.save
        flash[:notice] = "Category was updated successfully."
        redirect_to edit_category_path(@category)
      else
        flash.now[:alert] = "Error saving category. Please try again."
        render :edit
      end
    end

    def destroy
      @category = Category.find(params[:id])

      if @category.destroy
        flash[:notice] = "\"#{@category.name}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleting the category."
        render :show
      end
    end

    private

    def category_params
      params.require(:category).permit(:name, :slug, :icon, :body, :meta_title, :meta_description, :meta_keywords)
    end
  end
end
