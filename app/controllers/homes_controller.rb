class HomesController < ApplicationController
  

  # GET /homes
  # GET /homes.json
  def index

   #  cancan
   # if  admin_user_signed_in?
   #   @user=current_admin_user
   #   render :plain => @user.role
   # end
    
    if !params[:search].nil? 
      squares = Mysquare.arel_table
      #render :plain => params[:search]
      @squares=Mysquare.where(squares[:name].matches("%#{params[:search]}%")).paginate(:page => params[:page], :per_page => 2)
      
    else
    
     @squares= Mysquare.paginate(:page => params[:page], :per_page => 5)
   
    end
    
  

  end

  # GET /homes/1
  # GET /homes/1.json

   def search
  
   end


  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params[:home]
    end
end
