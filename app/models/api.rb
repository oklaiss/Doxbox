class Api < ActiveRecord::Base
  has_many :users, :through => :api_users
  has_many :api_users 
end
