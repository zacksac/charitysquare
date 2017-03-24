require "instagram"
class CharityusersquaresController < ApplicationController
  before_action :set_charityusersquare, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def index
    @charityusersquares = Charityusersquare.all
    respond_with(@charityusersquares)
  end

  def show
    @follow = Follow.all
    if @follow.empty?
      Charityusersquare.find(params[:id]).update_attributes!(:follow_status => "follow")
      @follow_status = "unfollow"
    end  
    @charitymedia=@charityusersquare.charitymedium
    squareid=@charityusersquare.user_id
    @charity=User.find(squareid)
    @charityname=@charity.charityname
    @charityuser=@charity.firstname
    @charitymission=@charity.mission
    respond_with(@charityusersquare)
  end

  def new
    @bet = Bet.new
    @charityusersquare = Charityusersquare.new
    @charityusersquareid=@charityusersquare.id
    @charitypics=CharityMedia.where(["charity_id = :u", { u: @charityusersquareid }])
       @charity=User.where("role = ?", 'charity')
    @list=[]
    @charity.each do |i|
      @list << [i.charityname,i.id]
    end
    respond_with(@charityusersquare)
  end

  def remove_picture
  render :plain =>" tst"
  end

  def edit
    @charityusersquareid=@charityusersquare.id
    @charitypics=CharityMedia.where(["charityusersquare_id = :u", { u: @charityusersquareid }])
 
  end
  
  def getpics
  @charitypics=CharityMedia.where(["charityusersquare_id = :u", { u: @charityusersquareid }])
  # render :plain => @charitypics.inspect
  
  end

  def create

    @charityusersquare = Charityusersquare.new(charityusersquare_params)
    @charityusersquare.user_id=current_user.id
    @charityusersquare.save
    respond_with(@charityusersquare)
  end

  def update
    @charityusersquare.update(charityusersquare_params)
    respond_with(@charityusersquare)
  end

  def destroy
    @charityusersquare.destroy
    respond_with(@charityusersquare)
  end

  def charity
    if current_user == nil
      new_user_session_path
    else
      @charity = current_user.charityusersquares
    end  
      charity_path
  end  

  def buynow
   render :plain =>params.inspect  
  end

  def follow
    # @follow = Follow.all
    #   if current_user.follows?(Charityusersquare.find(params[:id]))
    #     @follow_status = "unfollow"
    #     Charityusersquare.find(params[:id]).update_attributes!(:follow_status => "follow")
    #     current_user.unfollow!(Charityusersquare.find(params[:id]))
    #   else  
    #     @follow_status = "follow"
    #     Charityusersquare.find(params[:id]).update_attributes!(:follow_status => "unfollow")
    #     current_user.follow!(Charityusersquare.find(params[:id])) 
    #   end  
    # respond_to do |format|
    #   format.js 
    # end

  end 

  # def connect
  #   redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  # end

  # def callback
  #   binding.pry
  #   response = response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL, :client_secret => "160a455eee9d4133b0ccf8a1c492b2d0")
  #   session[:access_token] = response.access_token
  #   redirect_to :controller => 'Charityusersquares', :action => 'index'
  # end 

  def create_square

  end

  def bet
    @bet = Bet.new
    @charityusersquare = Charityusersquare.new
    @charityusersquareid=@charityusersquare.id
    @charitypics=CharityMedia.where(["charity_id = :u", { u: @charityusersquareid }])
       @charity=User.where("role = ?", 'charity')
    @list=[]
    @charity.each do |i|
      @list << [i.charityname,i.id]
    end
    respond_with(@charityusersquare)
  end
  
  def appeal
    @appeal= Appeal.new
    @charityusersquare = Charityusersquare.new
    @charityusersquareid=@charityusersquare.id
    @charitypics=CharityMedia.where(["charity_id = :u", { u: @charityusersquareid }])
       @charity=User.where("role = ?", 'charity')
    @list=[]
    @charity.each do |i|
      @list << [i.charityname,i.id]
    end
    respond_with(@charityusersquare)
  end  
  
  private
    def set_charityusersquare
      @charityusersquare = Charityusersquare.find(params[:id])
    end

    def charityusersquare_params
      params.require(:charityusersquare).permit(:user_id, :brand, :condition, :types, :color, :charitytype ,:sizeinfo ,:name ,:material,:description, :daysleft, :price)
    end
end


