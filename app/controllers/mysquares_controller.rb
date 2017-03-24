class MysquaresController < ApplicationController
  before_action :set_mysquare, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:create]
  respond_to :html

  def index
    @mysquares = Mysquare.all
    respond_with(@mysquares)
  end

  def show
    respond_with(@mysquare)
  end

  def new
    @mysquare = Mysquare.new
    respond_with(@mysquare)
  end

  def edit
  end

  def create
    @mysquare = Mysquare.new(mysquare_params)
    @mysquare.save
    respond_with(@mysquare)
  end

  def update
    #render :plain =>mysquare_params
    @mysquare.update(mysquare_params)
    respond_with(@mysquare)
 
  end

  def destroy
    @mysquare.destroy
    respond_with(@mysquare)
  end

  private
    def set_mysquare
      @mysquare = Mysquare.find(params[:id])
    end

    def mysquare_params
      params.require(:mysquare).permit(:name, :square_raiser_id, :info, :lat, :long ,:squarephoto)
    end
end
