require_dependency "o_cms/application_controller"

module OCms
  class PagesController < ApplicationController

    def index
      @pages  = Page.all
    end

    def show
      @page = Page.find(params[:id])
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)

      if @page.save
        flash[:notice] = "Page was saved successfully."
        redirect_to edit_page_path(@page)
      else
        flash.now[:alert] = "Error creating page. Please try again."
        render :new
      end
    end

    def edit
      @page = Page.find(params[:id])
    end

    def update
      @page = Page.find(params[:id])
      @page.assign_attributes(page_params)

      if @page.save
        flash[:notice] = "Page was updated successfully."
        redirect_to edit_page_path(@page)
      else
        flash.now[:alert] = "Error saving page. Please try again."
        render :edit
      end
    end

    def destroy
      @page = Page.find(params[:id])

      if @page.destroy
        flash[:notice] = "\"#{@page.title}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleting the page."
        render :show
      end
    end

    private

    def page_params
      params.require(:page).permit(:title, :slug, :body, :excerpt, :featured_image, :meta_title, :meta_description, :meta_keywords)
    end
  end
end
