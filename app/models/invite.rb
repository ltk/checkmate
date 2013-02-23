class Invite < ActiveRecord::Base
  attr_accessible :email, :user_id

  belongs_to :user

  validates :email,
            :presence => true,
            :email => true

  validates :user_id,
            :presence => true,
            :numericality => true
end
