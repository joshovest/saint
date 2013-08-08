class Site < ActiveRecord::Base
  attr_accessible :name, :suite_list
  before_save :prep_list_for_save
  
  validates :name, presence:true
  validates :suite_list, presence:true
  
  def prep_list_for_save
    self.suite_list = self.suite_list.gsub("\n", ",").gsub("\r", "")
  end
  
  def prep_list_for_form
    suite_list = self.suite_list.gsub(",", "\r\n")
  end
  
  def prep_list_for_display
    suite_list = self.suite_list.gsub(",", "<br>").html_safe
  end
  
  def run_classifications(max_pages)
    require 'omni'
    o = Omni.new
    html = o.classify(self, max_pages)
  end
end