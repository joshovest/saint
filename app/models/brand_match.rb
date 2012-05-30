class BrandMatch < ActiveRecord::Base
  attr_accessible :match_list, :exclude_list
  before_save :prep_match_for_save
  before_save :prep_exclude_for_save
  
  validates :match_list, presence:true
  
  def prep_match_for_save
    self.match_list = self.match_list.gsub("\n", ",").gsub("\r", "")
  end
  
  def prep_match_for_form
    match_list = self.match_list.gsub(",", "\r\n")
  end
  
  def prep_match_for_display
    match_list = self.match_list.gsub(",", "<br>").html_safe
  end
  
  def prep_exclude_for_save
    self.exclude_list = self.exclude_list.gsub("\n", ",").gsub("\r", "")
  end
  
  def prep_exclude_for_form
    exclude_list = self.exclude_list.gsub(",", "\r\n")
  end
  
  def prep_exclude_for_display
    exclude_list = self.exclude_list.gsub(",", "<br>").html_safe
  end
end
