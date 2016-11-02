require_dependency "o_cms/application_controller"

module OCms
  class GalleriesController < ApplicationController

    def index
      @galleries = Gallery.all
    end

    def show
      @gallery = Gallery.find(params[:id])
    end

    def new
      @gallery = Gallery.new
      @images = Image.all
    end

    def create
      @gallery = Gallery.new(gallery_params)

      if @gallery.save
        flash[:notice] = "Gallery was saved successfully."
        redirect_to edit_gallery_path(@gallery)
      else
        flash.now[:alert] = "Error creating gallery. Please try again."
        render :new
      end
    end

    def edit
      @gallery = Gallery.find(params[:id])
      @images = Image.all
    end

    def update
      @gallery = Gallery.find(params[:id])
      @gallery.assign_attributes(gallery_params)

      if @gallery.save
        flash[:notice] = "Gallery was updated successfully."
        redirect_to edit_gallery_path(@gallery)
      else
        flash.now[:alert] = "Error saving gallery. Please try again."
        render :edit
      end
    end

    def destroy
      @gallery = Gallery.find(params[:id])

      if @gallery.destroy
        flash[:notice] = "\"#{@gallery.name}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleting the gallery."
        render :show
      end
    end

    private

    def gallery_params
      params.require(:gallery).permit(:name, :description, :image_ids => [])
    end
  end
end
