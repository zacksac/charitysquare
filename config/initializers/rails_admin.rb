RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  config.model Faq do
    edit do
      field :content, :ck_editor
    end
  end

  config.model User do
   list do
     field :firstname
     field :lastname
     field :email
     field :role
     field :address
     field :charityname
     field :charitytype
     field :charitynumber
     field :category
     field :country
     field :town
     field :postcode
     field :webaddress
     field :picture
     field :mission
     field :opt1
     field :opt2
     field :address1
     field :address2
     field :confirmed
   end
  end

  config.model Bet do
   list do
     field :id
     field :charityusersquare_id
     field :amount
     field :timeend
     field :response
     field :name
     field :description
     field :enddate
     field :user_id
     field :charitytype
     field :active
     field :follow_status
     field :subject
     field :objective
     field :startdate
   end
  end

  config.model CharityMedia do
   list do
     field :id
     field :charityusersquare_id
     field :types
     field :desc
     field :picture
     field :bet_id
   end
  end
  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.included_models = [ Bet, BetResult, BetResponse, AdminUser, CharityMedia, InvitedUser, PaymentDetail, User ]
  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
