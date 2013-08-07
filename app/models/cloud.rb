class Cloud < ActiveRecord::Base
  has_many :cloud_matches, :dependent => :destroy
  
  validates :name, presence:true
end
