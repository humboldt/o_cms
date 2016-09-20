require_dependency "o_cms/application_controller"

module OCms
  class ImagesController < ApplicationController

    def show
      @image = Image.find(params[:id])
    end

    private
 
    def image_params
      params.require(:image).permit(:name, :file, :description)
    end
  end
end
