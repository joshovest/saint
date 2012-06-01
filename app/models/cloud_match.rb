class CloudMatch < ActiveRecord::Base
  attr_accessible :match_list, :cloud_id, :and_match, :position
  belongs_to :cloud
  before_save :prep_list_for_save
  
  validates :match_list, presence:true
  validates :cloud_id, presence:true
  
  def prep_list_for_save
    self.match_list = self.match_list.gsub("\n", ",").gsub("\r", "")
  end
  
  def prep_list_for_form
    match_list = self.match_list.gsub(",", "\r\n")
  end
  
  def prep_list_for_display
    match_list = self.match_list.gsub(",", "<br>").html_safe
  end
end