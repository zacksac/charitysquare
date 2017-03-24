class BetsController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :set_bet, only: [:show, :edit,  :destroy]
  before_action :create, only: [:create]

  respond_to :html,:js

  def index
    @bets = Bet.all
    respond_with(@bets)
  end
   
  def show
    if !current_user.nil?
      sign_out current_user
    end
    sign_in User.find(params[:user_id].to_i)
    @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]
    
    # @tz = TimeZone::Local.get()

    #@time_left = distance_of_time_in_words(Bet.find(params[:id]).enddate, Bet.find(params[:id]).startdate)
    # @time_left=2
    # @inv_users = InvitedUser.all

    # if @time_left == "less than a minute"
    #   if @inv_users.count == 1                                           
    #     if BetResult.find_by_bet_id(params[:id]).answer == BetResponse.find_by_user_id(@inv_users.first.user_id).response
    #       UserMailer.bet_result(User.find(@inv_users.first.user_id).email, "win").deliver
    #     else  
    #       UserMailer.bet_result(User.find(@inv_users.first.user_id).email, "lose").deliver
    #     end
    #   else
    #    @inv_users.each do |i|
    #     if BetResult.find_by_bet_id(params[:id]).answer == BetResponse.find_by_user_id(i.user_id).response
    #       UserMailer.bet_result(User.find_by_id(i.user_id).email, "win").deliver
    #     else 
    #       UserMailer.bet_result(User.find_by_id(i.user_id).email, "lose").deliver
    #     end
    #    end 
    #   end     
    # end  
     
    respond_with(@bet)
  end

  def new
    @bet = Bet.new
  end

  def edit

    @crtrlr = params[:controller]
    @charityusersquare = Charityusersquare.new
    @charityusersquareid=@charityusersquare.id
    @charitypics=CharityMedia.where(["charityusersquare_id = :u", { u: @bet.id }])
    @charity=User.where("role = ?", 'charity')
    @list=[]
    @charity.each do |i|
    @list << [i.charityname,i.id]
   
    end
  end

  def create
    @bet = Bet.new(bet_params)
    @bet.user_id=params[:bet][:user_id]
    @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]
    @bet.startdate = Time.now.in_time_zone(@tz).to_s
    if params[:bet][:enddate].present?
      @bet.enddate = params[:bet][:enddate].in_time_zone(@tz).to_s
    end
    # UserMailer.bet_result1(@bet.startdate, @bet.enddate).deliver   
    @bet.charitytype=@bet.charitytype.downcase
    @bet.active = true
     if @bet.save
      # entry in bet response #
      @br=BetResponse.new
      @br.bet_id=@bet.id
      @br.user_id=@bet.user_id
      @br.response= 1
      @br.save
      #end#
      
      bet_id=@bet.id
      @params = params
      unless @params[:recipients].nil?
      @params[:recipients].each do |f|
        @invite = InvitedUser.new
        @invite.user_id = f.to_i
        @invite.user_email = User.find(f.to_i).email
        @invite.bet_id = @bet.id
        @invite.save
        UserMailer.invite(@params, User.find_by_id(f.to_i), @bet.id).deliver
      end 
     end 

     unless @params["hidden-custom_recipients"].split(',').nil?
      @params["hidden-custom_recipients"].split(',').each do |p|
        @invite = InvitedUser.new
        @invite.bet_id = @bet.id
        @invite.user_email = p
        @invite.save
        UserMailer.invite1(@params, p, @bet.id).deliver
      end 
     end 
      
     if params[:image_array]
     temp=[]
     params[:image_array].each do |encoded_img|
      

     bet_media= CharityMedia.new(:charityusersquare_id=>bet_id)
     bet_media.save
     created_bet_id=bet_media.id
     path="#{Rails.root}/public/images/#{created_bet_id}.jpg"
     temp.push path
         File.open("#{path}","wb") do |file|
         file.write(Base64.decode64(encoded_img.split(/,/)[1]))
         end
        
     @update=CharityMedia.find(created_bet_id)
     @update.picture=@update.id
     @update.save()
      # image = MiniMagick::Image.open("#{path}")
      # image.resize("192x140!")
      # image.format("png", 1)
      # image.write("#{path}")
      end
      end

      @bet.startdate=@bet.startdate.to_time.in_time_zone(@tz)
      @bet.enddate=@bet.enddate.to_time.in_time_zone(@tz)
      @time_left = distance_of_time_in_words(@bet.enddate, @bet.startdate)
      # @time_in_minutes=(params[:bet][:enddate].to_time - @bet.startdate.to_time)/60
      @time_in_minutes=(@bet.enddate.to_time - @bet.startdate.to_time)/60
      
      @time_enque=@time_in_minutes.floor
  
      Delayed::Job.enqueue(MailingJob.new(@bet.user_id, @bet.id, params[:bet][:amount].to_i), -3, @time_enque.minutes.from_now.in_time_zone(@tz))
      flash[:notice]= "Bet Created" 
      redirect_to my_square_path
      else
         
       flash[:alert] = @bet.errors.full_messages.to_sentence
      
       
        # flash[:notice] = @abc.to_a[0] + @abc.to_a[1] + @abc.to_a[2]
        # render 'charityusersquare/new'
      redirect_to(new_charityusersquare_path) 
      # render 'charityusersquares/new'
     end
  end

  def update
    # binding.pry
     @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]

     @betid=params[:bet][:id]

     @bet=Bet.find(@betid)
     @startdate = Time.now.in_time_zone(@tz).to_s
    if params[:bet][:enddate].present?
      @enddate = params[:bet][:enddate].in_time_zone(@tz).to_s
    end

    # UserMailer.bet_result1(@bet.startdate, @bet.enddate).deliver   
    @bet.update_attributes!(:user_id => params[:bet][:user_id] , :charityusersquare_id =>params[:bet][:charityusersquare_id], :description => params[:bet][:description], :amount => params[:bet][:amount] , :subject =>params[:bet][:subject], :objective =>params[:bet][:objective], :enddate =>@enddate, :charitytype=>params[:bet][:charitytype].downcase)
   
      bet_id=@betid
      @params = params
          #mail #
                #binding.pry
                unless @params[:recipients].nil?
                @params[:recipients].each do |f|
                  @invite = InvitedUser.new
                  @invite.user_id = f.to_i
                  @invite.user_email = User.find(f.to_i).email
                  @invite.bet_id = @bet.id
                  @invite.save
                  UserMailer.invite(@params, User.find_by_id(f.to_i), @bet.id).deliver
                end 
                end 
          if params[:image_array]
           temp=[]
           params[:image_array].each do |encoded_img|
            

           bet_media= CharityMedia.new(:charityusersquare_id=>bet_id)
           bet_media.save
           created_bet_id=bet_media.id
           path="#{Rails.root}/public/images/#{created_bet_id}.jpg"
           temp.push path
               File.open("#{path}","wb") do |file|
               file.write(Base64.decode64(encoded_img.split(/,/)[1]))
               end
              
           @update=CharityMedia.find(created_bet_id)
           @update.picture=@update.id
           @update.save()
            # image = MiniMagick::Image.open("#{path}")
            # image.resize("192x140!")
            # image.format("png", 1)
            # image.write("#{path}")
            end
            end

      @startdate=@startdate.to_time.in_time_zone(@tz)
      @enddate=@enddate.to_time.in_time_zone(@tz)
      @time_left = distance_of_time_in_words(@enddate, @startdate)
      # @time_in_minutes=(params[:bet][:enddate].to_time - @bet.startdate.to_time)/60
      @time_in_minutes=(@enddate.to_time - @startdate.to_time)/60
      
      @time_enque=@time_in_minutes.floor
  
      Delayed::Job.enqueue(MailingJob.new(@bet.user_id, @bet.id, params[:bet][:amount].to_i), -3, @time_enque.minutes.from_now.in_time_zone(@tz))
      flash[:notice]= "Bet Updated" 
      redirect_to my_square_path
    


   
   
  end

  def destroy
    @bet.destroy
    respond_with(@bet)
  end

  def delete 
    @delbet=params[:id]
    Bet.find(@delbet).delete
        BetResponse.where(:bet_id => @delbet).each do |bet|
          bet.delete
        end
        BetResult.where(:bet_id => @delbet).each do |bet|
          bet.delete
        end
        CharityMedia.where(:charityusersquare_id => @delbet).each do |media|
          media.delete
          File.delete(Rails.root + "public/images/#{media.picture.to_s}.jpg")
        end  
  end


  def follows
    @follow = Follow.all
      if current_user.follows?(User.find(params[:id]))
        @follow_status = "unfollow"
        User.find(params[:id]).update_attributes!(:follow_status => "follow")
        current_user.unfollow!(User.find(params[:id]))
      else  
        @follow_status = "follow"
        User.find(params[:id]).update_attributes!(:follow_status => "unfollow")
        current_user.follow!(User.find(params[:id])) 
      end  
    respond_to do |format|
      format.js 
    end
  end 

  def bet_response
    @bet = BetResponse.new
    if params[:response] == "yes"
      @bet.response = true
    else 
      @bet.response = false
    end  
      @bet.user_id = current_user.id
      @bet.bet_id = params[:id]
      if BetResponse.where('user_id=? and bet_id=?', current_user.id, params[:id]).present? 
        flash[:alert] = "You have already Placed this Bet!!!"
      else 
        @bet.save
        flash[:notice] = "Your Bet has been Placed!!!" 
      end 
      redirect_to :back
  end


  def bet_result
    @betres = BetResult.new
    if params[:response] == "yes"
      @betres.answer = true
    else 
      @betres.answer = false
    end  
    @betres.bet_id = params[:bet_id]
    @betres.save
    Bet.find(@betres.bet_id).update_attributes!(:active => false)

    flash[:notice] = "Your have set the bet result!!!" 
    @response = BetResponse.where("bet_id=?", params[:id])
    @response.each do |resp|
      UserMailer.bet_result(resp, @betres.answer).deliver
    end
    # respond_to do |format|
     #  format.js 
    # end
     redirect_to :back
  end

  def bet_result1
    @bet_response = BetResponse.where("bet_id=?", params[:id])
  end  

  def removepic

   @mediaid=params[:pic]
   CharityMedia.find(@mediaid).destroy
   render :js => 'deleted'
  
  end 


  def invite
    @params = params
     unless @params[:recipients].nil?
      @params[:recipients].each do |f|
        @invite = InvitedUser.new
        @invite.user_id = f.to_i
        @invite.user_email = User.find(f.to_i).email
        @invite.bet_id = params[:bet_id].to_i
        @invite.save
        UserMailer.invite(@params, User.find_by_id(f.to_i)).deliver
      end 
     end 

     unless @params["hidden-custom_recipients"].split(',').nil?
      @params["hidden-custom_recipients"].split(',').each do |p|
        @invite = InvitedUser.new
        @invite.bet_id = params[:bet_id].to_i
        @invite.user_email = p
        @invite.save
        UserMailer.invite1(@params, p).deliver
      end 
     end 
    redirect_to :back
  end  

  def approve
   @bet=Bet.where(:id=>params[:id])
   @bet.first.active= true
   @bet.first.save
   flash[:notice]= "Bet Aprroved" 
   redirect_to my_square_path
  end 

  private
    def set_bet
      
      @bet = Bet.find(params[:id])    
    end

    def bet_params
      params.require(:bet).permit(:user_id,:charitytype,:charityusersquare_id,:amount,:subject,:objective,:response,:name,:description,:enddate,:image_array)
    end

end
