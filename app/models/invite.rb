class Invite < ActiveRecord::Base
  attr_accessible :email, :user_id

  belongs_to :user

  validates :email,
            :presence => true,
            :email => true

  validates :user_id,
            :presence => true,
            :numericality => true

  before_validation :generate_code, :on => :create
  after_save :deliver, :on => :create

  def generate_code
    self.code = Digest::SHA1.hexdigest("--#{Time.now.utc.to_s}--#{self.email}--")
  end

  def deliver
    InviteMailer.invite(self).deliver
  end
end
