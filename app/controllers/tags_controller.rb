class TagsController < ApplicationController
 
    def create
        Tag.create(tag_params)
    end

    private
    
    def tag_params
        params.require(:tag).permit(:name, :description)
    end
    
end
