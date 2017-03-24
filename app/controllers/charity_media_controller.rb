class CharityMediaController < ApplicationController
	
	def upload
	u=CharityMedia.new
	u.picture=params[:charity_media][:picture]
	u.charityusersquare_id= params[:charity_media][:squareid]
	charityid=params[:charity_media][:squareid]
	u.save
	redirect_to edit_charityusersquare_path(charityid)
	
	end

	def remove_picture
     picid=params[:id]
     pic=CharityMedia.find_by_id(params[:id])
     pic.destroy
     redirect_to edit_charityusersquare_path(pic.charityusersquare_id)

    end

	

	def create
	@params=params
	render :plain => @params.inspect
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    
    def charity_media_params
      params.permit(:picture, :charityusersquare_id, :types, :desc)
    end


end
