require_dependency "o_cms/application_controller"

module OCms
  class ImagesController < ApplicationController

    def index
      @images = Image.all

      respond_to do |format|
        format.html
        format.js
      end
    end

    def show
      @image = Image.find(params[:id])

      respond_to do |format|
        format.html
        format.js
      end
    end

    def new
      @image = Image.new
    end

    def create
      @image = Image.new(image_params)

      if @image.save
        flash[:notice] = "Image was saved successfully."
        redirect_to @image
      else
        flash.now[:alert] = "Error creating image. Please try again."
        render :new
      end
    end

    def edit
      @image = Image.find(params[:id])
    end

    def update
      @image = Image.find(params[:id])
      @image.assign_attributes(image_params)

      if @image.save
        flash[:notice] = "Image was updated successfully."
        redirect_to @image
      else
        flash.now[:alert] = "Error saving image. Please try again."
        render :edit
      end
    end

    def destroy
      @image = Image.find(params[:id])

      if @image.destroy
        flash[:notice] = "\"#{@image.name}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleting the image."
        render :show
      end
    end

    private

    def image_params
      params.require(:image).permit(:name, :file, :description)
    end
  end
end
