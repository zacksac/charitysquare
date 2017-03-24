class CharitychildrenController < ApplicationController
  before_action :set_charitychild, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource except: [:create]
  respond_to :html

  def index
    if current_user != nil
      @charitychildren = current_user.charitychildren  
      respond_with(@charitychildren)
    end  
  end

  def show
    respond_with(@charitychild)
  end

  def new
    @charitychild = Charitychild.new
    respond_with(@charitychild)
  end

  def edit
  end

  def create
    @charitychild = current_user.charitychildren.new(charitychild_params)
    @charitychild.save
    respond_with(@charitychild)
  end

  def update
    #render :plain =>mysquare_params
    @charitychild.update(charitychild_params)
    respond_with(@charitychild)
 
  end

  def destroy
    @charitychild.destroy
    respond_with(@charitychild)
  end

  private
    def set_charitychild
      @charitychild = Charitychild.find(params[:id])
    end

    def charitychild_params
      params.require(:charitychild).permit(:name, :email, :address, :active, :user_id)
    end
end

