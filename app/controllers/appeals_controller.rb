class AppealsController < ApplicationController
  include ActionView::Helpers::DateHelper
  require 'paypal_adaptive'
  before_action :set_appeal, only: [:show, :edit,  :destroy]
  before_action :create, only: [:create]

  respond_to :html,:js

  def index
    @appeals = Appeal.all
    respond_with(@appeals)
  end
   
  def show
    if !current_user.nil?
      sign_out current_user
    end
    sign_in User.find(params[:user_id].to_i)
    @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]
    respond_with(@appeal)
  end

  def new
    @appeal = Appeal.new
  end

  def edit
    @crtrlr = params[:controller]
    @charityusersquare = Charityusersquare.new
    @charityusersquareid=@charityusersquare.id
    @charitypics=CharityMedia.where(["charityusersquare_id = :u", { u: @appeal.id }])
    @charity=User.where("role = ?", 'charity')
    @list=[]
    @charity.each do |i|
    @list << [i.charityname,i.id]
    end
  end

  def create
    @appeal = Appeal.new(appeal_params)
    @appeal.user_id=params[:appeal][:user_id]
    @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]
    @appeal.startdate = Time.now.in_time_zone(@tz).to_s
    if params[:appeal][:enddate].present?
      @appeal.enddate = params[:appeal][:enddate].in_time_zone(@tz).to_s
    end
    @appeal.charitytype=@appeal.charitytype.downcase
    @appeal.active = true
     if @appeal.save
      appeal_id=@appeal.id
      @params = params
      
     if params[:image_array]
     temp=[]
     params[:image_array].each do |encoded_img|
     appeal_media= CharityMedia.new(:charityusersquare_id=>appeal_id)
     appeal_media.save
     created_appeal_id=appeal_media.id
     path="#{Rails.root}/public/images/#{created_appeal_id}.jpg"
     temp.push path
         File.open("#{path}","wb") do |file|
         file.write(Base64.decode64(encoded_img.split(/,/)[1]))
         end
        
     @update=CharityMedia.find(created_appeal_id)
     @update.picture=@update.id
     @update.save()
      end
      end

      @appeal.startdate=@appeal.startdate.to_time.in_time_zone(@tz)
      @appeal.enddate=@appeal.enddate.to_time.in_time_zone(@tz)
      @time_left = distance_of_time_in_words(@appeal.enddate, @appeal.startdate)
      @time_in_minutes=(@appeal.enddate.to_time - @appeal.startdate.to_time)/60
      
      @time_enque=@time_in_minutes.floor
  
      Delayed::Job.enqueue(MailingJob.new(@appeal.user_id, @appeal.id), -3, @time_enque.minutes.from_now.in_time_zone(@tz))
      flash[:notice]= "Appeal Created" 
      redirect_to my_square_path
      else
         
       flash[:alert] = @appeal.errors.full_messages.to_sentence
      redirect_to(new_charityusersquare_path) 
     end
  end

  def update
     @tz = Geocoder.search(current_user.current_sign_in_ip)[0].data["timezone"]
     @appealid=params[:appeal][:id]

     @appeal=Appeal.find(@appealid)
     @startdate = Time.now.in_time_zone(@tz).to_s
    if params[:appeal][:enddate].present?
      @enddate = params[:appeal][:enddate].in_time_zone(@tz).to_s
    end

    @appeal.update_attributes!(:user_id => params[:appeal][:user_id] , :charityusersquare_id =>params[:appeal][:charityusersquare_id], :description => params[:appeal][:description], :appeal_type => params[:appeal][:appeal_type], :enddate =>@enddate, :charitytype=>params[:appeal][:charitytype].downcase, :specific_appeal_description=>params[:appeal][:specific_appeal_description])
   
      appeal_id=@appealid
      @params = params
          
          if params[:image_array]
           temp=[]
           params[:image_array].each do |encoded_img|
            

           appeal_media= CharityMedia.new(:charityusersquare_id=>appeal_id)
           appeal_media.save
           created_appeal_id=appeal_media.id
           path="#{Rails.root}/public/images/#{created_appeal_id}.jpg"
           temp.push path
               File.open("#{path}","wb") do |file|
               file.write(Base64.decode64(encoded_img.split(/,/)[1]))
               end
              
           @update=CharityMedia.find(created_bet_id)
           @update.picture=@update.id
           @update.save()

          end
        end

      @startdate=@startdate.to_time.in_time_zone(@tz)
      @enddate=@enddate.to_time.in_time_zone(@tz)
      @time_left = distance_of_time_in_words(@enddate, @startdate)
      @time_in_minutes=(@enddate.to_time - @startdate.to_time)/60
      
      @time_enque=@time_in_minutes.floor
  
      Delayed::Job.enqueue(MailingJob.new(@appeal.user_id, @appeal.id), -3, @time_enque.minutes.from_now.in_time_zone(@tz))
      flash[:notice]= "Appeal Updated" 
      redirect_to my_square_path
  end

  def destroy
    @appeal.destroy
    respond_with(@appeal)
  end

  def appeal_donations
    @appeal_donations = AppealDonation.new
    @appeal_donations.user_id = params[:user_id]
    @appeal_donations.appeal_id = params[:appeal_id]
    @appeal_donations.amount = params[:amount]
    @appeal_donations.save
    flash[:notice]= "Thank You for Donation!!!" 

    pay_request = PaypalAdaptive::Request.new
    data = {"returnUrl" => "http://esferasoftsolutions.com/order_confirmation?appeal_id=#{params[:appeal_id].to_i}&user_id=#{params[:user_id].to_i}&price=#{params[:amount]}", "requestEnvelope" => {"errorLanguage" => "en_US"}, "currencyCode"=>"USD", "receiverList"=>{"receiver"=>[{ "email"=>User.find_by_id(params[:user_id].to_i).paypal_email, "amount"=>params[:amount].to_f - ((5 * params[:amount].to_f)/100), "appealid"=>params[:appeal_id], "userid"=> params[:user_id]}, {"email"=>"charity-admin@esferasoft.com", "amount"=>(5 * params[:amount].to_f)/100}]}, "cancelUrl"=>"http://esferasoftsolutions.com/canceled_payment_request", "actionType"=>"PAY", "ipnNotificationUrl"=>"http://esferasoftsolutions.com/appeal_ipn?user_id=#{params[:user_id]}&appeal_id=#{params[:appeal_id]}&charitytype=#{params[:charitytype]}"}
    pay_response = pay_request.pay(data)
      
    if pay_response.success?
      redirect_to pay_response.approve_paypal_payment_url
    end 
    
  end

  def view_donations
    @appeal_donations = AppealDonation.where("appeal_id=?", params[:id])
  end  

  def removepic
   @mediaid=params[:pic]
   CharityMedia.find(@mediaid).destroy
   render :js => 'deleted'
  end 

  def approve
   @appeal=Appeal.where(:id=>params[:id])
   @appeal.first.active= true
   @appeal.first.save
   flash[:notice]= "Appeal Aprroved" 
   redirect_to my_square_path
  end 

  def appeal_ipn
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
      @payment.user_id = params["user_id"].to_i
      @payment.appeal_id = params["appeal_id"].to_i
      @payment.save
    else
      logger.info "IT DIDNT WORK"
    end

    render nothing: true
   end


  private
    def set_appeal
      @appeal = Appeal.find(params[:id])    
    end

    def appeal_params
      params.require(:appeal).permit(:user_id, :charitytype, :charityusersquare_id, :description, :enddate, :image_array, :startdate, :active, :appeal_type, :specific_appeal_description)
    end
end
