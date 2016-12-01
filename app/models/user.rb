class User < ActiveRecord::Base
  enum role: [:user, :contractor, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :apis, :through => :api_users
  has_many :api_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
    self.role ||= :contractor
  end
end
