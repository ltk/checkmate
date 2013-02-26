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

  mount_uploader :avatar, AvatarUploader
end
