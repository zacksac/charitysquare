class HomeController < ApplicationController
  # before_action :authenticate_user!, only: [:checkout, :order_confirmation]
  before_filter :searching
  require 'paypal_adaptive'
  require 'will_paginate/array'
  include ActiveMerchant::Billing::Integrations 

  def index
    #@usercharitysquare=Charityusersquare.find_by_userid(3)
    #render :plain => @usercharitysquare.inspect 
  end

  def charity_signup
  end
 
  def login
  end 

  def search
    @params = params
    render :plain => @params.inspect
  end

  def searching
 	  if params[:q] == ""
      @q = params[:category]
      @searchname=params[:q]
 		  @users = User.all
 		  @charity = Charityusersquare.where(:charitytype => @q)
      @count=@charity.count
 	  else	
	    @q = params[:category]
      @searchname=params[:q]
	    @users   = User.search(charitytype_or_address_cont: @q).result
      query = Charityusersquare.where(:charitytype => @q)
      query = query.where('name LIKE (?) ',@searchname) if @searchname.present?
      @count=query.count
      @charity=query
    end  
  end


  def charity_squares
 	  @charity_squares = Charityusersquare.all
  end
 
  def buy_now
  end

  def appeals
 	  @appeals = Charityusersquare.where(:charitytype => "appeals")
  end	

  def auctions
 	  @auctions = Charityusersquare.where(:charitytype => "auctions")
  end

  def raffle_n_lottery
 	  @raffle_n_lottery = Charityusersquare.where(:charitytype => "raffles") || Charityusersquare.where(:charitytype => "raffles")
  end

  def bets
 	  @bets = Bet.where(:active => true)
  end	

  def pay
    if current_user.present?
      if current_user.id == params[:user_id].to_i
        pay_request = PaypalAdaptive::Request.new
        data = {"returnUrl" => "http://esferasoftsolutions.com/order_confirmation?bet_id=#{params[:bet_id].to_i}&user_id=#{params[:user_id].to_i}&price=#{params[:price]}", "requestEnvelope" => {"errorLanguage" => "en_US"}, "currencyCode"=>"USD", "receiverList"=>{"receiver"=>[{ "email"=>User.find_by_id(params[:user_id].to_i).paypal_email, "amount"=>params[:price].to_f - ((5 * params[:price].to_f)/100), "betid"=>params[:bet_id], "userid"=> params[:user_id]}, {"email"=>"charity-admin@esferasoft.com", "amount"=>(5 * params[:price].to_f)/100}]}, "cancelUrl"=>"http://esferasoftsolutions.com/canceled_payment_request", "actionType"=>"PAY", "ipnNotificationUrl"=>"http://esferasoftsolutions.com/ipn_notification?userid=#{params[:user_id]}&betid=#{params[:bet_id]}&charitytype=#{params[:charitytype]}"}
        pay_response = pay_request.pay(data)
        #render :json => pay_response['payKey']
        if pay_response.success?
          redirect_to pay_response.approve_paypal_payment_url
        end 
      else
        sign_out current_user
        sign_in User.find(params[:user_id])
          pay_request = PaypalAdaptive::Request.new
        data = {"returnUrl" => "http://esferasoftsolutions.com/order_confirmation?bet_id=#{params[:bet_id].to_i}&user_id=#{params[:user_id].to_i}&price=#{params[:price]}", "requestEnvelope" => {"errorLanguage" => "en_US"}, "currencyCode"=>"USD", "receiverList"=>{"receiver"=>[{ "email"=>User.find_by_id(params[:user_id].to_i).paypal_email, "amount"=>params[:price].to_f - ((5 * params[:price].to_f)/100), "betid"=>params[:bet_id], "userid"=> params[:user_id]}, {"email"=>"charity-admin@esferasoft.com", "amount"=>(5 * params[:price].to_f)/100}]}, "cancelUrl"=>"http://esferasoftsolutions.com/canceled_payment_request", "actionType"=>"PAY", "ipnNotificationUrl"=>"http://esferasoftsolutions.com/ipn_notification?userid=#{params[:user_id]}&betid=#{params[:bet_id]}&charitytype=#{params[:charitytype]}"}
        pay_response = pay_request.pay(data)
        #render :json => pay_response['payKey']
        if pay_response.success?
          redirect_to pay_response.approve_paypal_payment_url
        end 
      end  
    else
      sign_in User.find(params[:user_id])
        pay_request = PaypalAdaptive::Request.new
        data = {"returnUrl" => "http://esferasoftsolutions.com/order_confirmation?bet_id=#{params[:bet_id].to_i}&user_id=#{params[:user_id].to_i}&price=#{params[:price]}", "requestEnvelope" => {"errorLanguage" => "en_US"}, "currencyCode"=>"USD", "receiverList"=>{"receiver"=>[{ "email"=>User.find_by_id(params[:user_id].to_i).paypal_email, "amount"=>params[:price].to_f - ((5 * params[:price].to_f)/100), "betid"=>params[:bet_id], "userid"=> params[:user_id]}, {"email"=>"charity-admin@esferasoft.com", "amount"=>(5 * params[:price].to_f)/100}]}, "cancelUrl"=>"http://esferasoftsolutions.com/canceled_payment_request", "actionType"=>"PAY", "ipnNotificationUrl"=>"http://esferasoftsolutions.com/ipn_notification?userid=#{params[:user_id]}&betid=#{params[:bet_id]}&charitytype=#{params[:charitytype]}"}
        pay_response = pay_request.pay(data)
        #render :json => pay_response['payKey']
        if pay_response.success?
          redirect_to pay_response.approve_paypal_payment_url
        end 
    end   

  end    

  def filter
    if params[:maintype].present? || params[:condition].present?
       query = Charityusersquare.all
       query = query.where("charitycategory IN (?)", params[:maintype]) if params[:maintype].present?
       query = query.where("color IN (?)", params[:condition]) if params[:condition].present?
       @query=query
       @charity=@query
       @count=@charity.count

    end
  end 
  # def completed_payment_request
  #   flash[:notice] = "Payment Completed"
  #   redirected_to root_url
  # end  

   def ipn_notification
     @params = params
     ipn = PaypalAdaptive::IpnNotification.new
     ipn.send_back(env['rack.request.form_vars'])
    if ipn.verified?
      @payment= PaymentDetail.new 
      @payment.transaction_id = params["transaction"]["0"][".id_for_sender_txn"]
      @payment.sender_email = params["sender_email"]
      @payment.receiver_email = params["transaction"]["0"][".receiver"]
      @payment.date = params["payment_request_date"]
      @payment.charitytype = params["charitytype"]
      @payment.amount = params["transaction"]["0"][".amount"].scan(/\d+/).first.to_f
      @payment.user_id = params["userid"].to_i
      @payment.bet_id = params["betid"].to_i
      @payment.save
    else
      logger.info "IT DIDNT WORK"
    end

    render nothing: true
   end

  def my_square
    @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]
    @my_bets =  Bet.where("user_id=?", current_user.id)
    @my_appeals =  Appeal.where("user_id=?", current_user.id)
    @my_square = (@my_bets + @my_appeals).paginate(:page => params[:page], :per_page => 6)
  end

  def home_page_feed
    @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]
    @my_bets =  Bet.where(:active=>true)
    @my_appeals =  Appeal.where(:active=>true)
    @charityusers = (@my_bets + @my_appeals)
  end 

  def profile
    @profile = Charityusersquare.last(3)
  end  

   def profile_edit
    @user = current_user
    @profile = Charityusersquare.last(3)
  end

  def edit_profile
    @user = current_user
    if params[:banner] || params[:profile]
     temp1=[]
     temp2=[]
     # bet_media= CharityMedia.new(:charityusersquare_id=>bet_id)
     # bet_media.save
     created_user_id=@user.id
     path1="#{Rails.root}/public/images/profile/pro#{created_user_id}.jpg"
     path2="#{Rails.root}/public/images/banner/ban#{created_user_id}.jpg"
     temp1.push path1
     temp2.push path2
      if params[:profile].present?   
        File.open("#{path1}","wb") do |file|
         file.write(Base64.decode64(params[:profile].split(/,/)[1]))
        end
      end 
       
      if params[:banner].present?     
        File.open("#{path2}","wb") do |file|
          file.write(Base64.decode64(params[:banner].split(/,/)[1]))
        end 
      end    
     @update=User.find(current_user.id)
     # @update.profile_image=@update.id.to_s+".jpg"
     # @update.banner_image=@update.id.to_s+".png"
     @update.update_attributes!(:banner_image=>"ban"+@update.id.to_s+".jpg", :profile_image=>"pro"+@update.id.to_s+".jpg", :instagram_field=>params[:user][:instagram_field], :twitter_field=>params[:user][:twitter_field], :youtube_field=>params[:user][:youtube_field], :fb_field=>params[:user][:fb_field], :firstname=>params[:user][:firstname], :mission=>params[:user][:mission])
      # image = MiniMagick::Image.open("#{path}")
      # image.resize("192x140!")
      # image.format("png", 1)
      # image.write("#{path}")
      end
    redirect_to :back
  end

  def order_summary
    @summary = Feedback.new
    @summary.feed = params[:feed]
    @summary.rating = params[:rating]
    if params[:arrival] == "Yes"
      @summary.arrival = true
    else
      @summary.arrival = false
    end  
    @summary.save
  end  

  def manage_purchase  
    if current_user.role == 'charity'
    @user_email=current_user.paypal_email
    # @transaction= PaymentDetail.where(:receiver_email => @user_email).group('bet_id || appeal_id').paginate(:page => params[:page], :per_page => 6)
    @transaction= PaymentDetail.where(:receiver_email => @user_email) #.paginate(:page => params[:page], :per_page => 6)

    else
    @user_email=current_user.paypal_email
    # @transaction= PaymentDetail.where(:sender_email => @user_email).group('bet_id || appeal_id').paginate(:page => params[:page], :per_page => 6)
    @transaction= PaymentDetail.where(:sender_email => @user_email).paginate(:page => params[:page], :per_page => 6)

    end

  end

  def purchase_result
    
  end


  def checkout
    sign_out current_user
    sign_in User.find(params[:user_id])
  end

  def order_confirmation
    sign_out current_user
    sign_in User.find(params[:user_id])
    # params = params
    # @params.amount = params["transaction"]["0"][".amount"].scan(/\d+/).first.to_f
    # UserMailer.welcome_email(@params).deliver
  end

  def view_transaction
    @pd = PaymentDetail.where("user_id = ? AND bet_id = ?", params[:user_id].to_i, params[:bet_id])  
  end  

  def account_settings
    @user = current_user
  end  

  def select
    redirect_to :controller => 'charityusersquares', :action => 'new', :square => params[:square]
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    
    def payment_params
      params.permit(:transaction_id, :sender_email, :receiver_email, :date, :charitytype, :amount)
    end

end


