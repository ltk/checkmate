class User < ActiveRecord::Base
  include SimplestAuth::Model
  authenticate_by :email

  attr_accessible :email, :password, :password_confirmation, :avatar

  has_many :invites
  
  validates :email,
            :presence => true,
            :uniqueness => true,
            :email => true
  validates :password, :confirmation => true
  validates :password, :length => { :minimum => 5 }, :if => :password_required?
  validates :password, :password_confirmation, :presence => true, :on => :create
  validates :password_reset_token, :uniqueness => true, :allow_nil => true

  mount_uploader :avatar, AvatarUploader

  def set_password_reset_token
    update_attribute(:password_reset_token, SecureRandom.uuid)
  end
end
