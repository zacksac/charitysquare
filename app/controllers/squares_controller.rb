class SquaresController < ApplicationController
  

before_action :set_square, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @squares = Square.all
    respond_with(@squares)
  end

  def show
    respond_with(@square)
  end

  def new
    @square = Square.new
    respond_with(@square)
  end

  def edit
  end

  def create
    @square = Square.new(square_params)
    @square.save
    respond_with(@square)
  end

  def update
    @square.update(square_params)
    respond_with(@square)
  end

  def destroy
    @square.destroy
    respond_with(@square)
  end

  private
    def set_square
      @square = Square.find(params[:id])
    end

    def square_params
      params.require(:square).permit(:name, :square_raiser_id, :info, :lat, :long)
    end
end
