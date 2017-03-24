class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  extend Mailboxer::Models::Messageable::ActiveRecordExtension
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  # geocoded_by :address   # can also be an IP address
  # after_validation :geocode          # auto-fetch coordinates  
  has_many :charityusersquares, :dependent => :destroy
  has_many :charitychildren, :dependent => :destroy
  has_many :betresponses, :class_name => 'BetResponse'
  has_many :invitedusers, :class_name => 'InvitedUser'
  has_many :appeal_donations, :dependent => :destroy
  validates_presence_of :firstname,:lastname , :if => Proc.new{|f| f.formtype=='charityform' } 
  validates :charitynumber, :numericality => true , :if => Proc.new{|f| f.formtype=='charityform' } 
  validates_presence_of :password, :on =>:create
  validates_confirmation_of :password, :on =>:create
  mount_uploader :picture, PictureUploader  
  acts_as_messageable
  acts_as_follower
  acts_as_followable
  letsrate_rater
  
  def name
    email
  end

  def mailboxer_email(object)
    email
  end

end
