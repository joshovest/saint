class Classification < ActiveRecord::Base
  attr_accessible :key
  
  validates :key, presence:true
  validates :type, presence:true
  
  after_initialize do
    return nil if self.key.nil?
    
    key_elements = self.key.split("|")
    self.type = get_type(key_elements)
    if self.valid? && (key_elements.count > 1)
      self.keyword = get_keyword(key_elements)
      self.branded = get_branded
      self.engine = get_engine(key_elements)
      self.country = get_country(key_elements)
      self.tld = get_tld(key_elements)
      self.keyword_cloud = get_keyword_cloud
      self.display_country = get_display_country(key_elements)
      self.display_site = get_display_site(key_elements)
      self.display_product = get_display_product(key_elements)
      self.display_date = get_display_date(key_elements)
      self.driver_id = get_driver_id(key_elements)
      self.name = get_name(key_elements)
    end
  end
  
  public
    def get_row
      row = [self.key, self.type, self.engine, self.tld, self.name, self.country, self.branded, self.keyword_cloud, self.display_country, self.display_site, self.display_product, self.display_date, self.driver_id]
    end
  
    def default_search
      "[NON-SEARCH TRAFFIC DRIVER]"
	end
	
	def default_display
	  "[NON-BANNER TRAFFIC DRIVER]"
	end
    
    def default_62org
      "[NON-62 ORG TRAFFIC DRIVER]"
    end
  
    def is_valid_type(type)
      valid = [ "External Websites", "SEO", "SFDC Network", "Social Media", "SEM", "BAN", "Email", "Other" ]
      valid.include?(type)
    end
  
    def get_type(els)
      return self.type if !self.type.nil?
      type = ""
      
	  els[0] = "External Websites" if (els[0] == "Link" || els[0].include?("External Website"))
      els[0] = "SFDC Network" if els[0] == "Force.com"
	  
	  type = els[0] if is_valid_type(els[0])
	  type = els[1] if is_valid_type(els[1])
	  type
    end
    
    def get_name(els)
      return self.name if !self.name.nil?
      
      driver_name = ""
      if self.driver_id != default_62org()
        if self.type == "SEO"
          self.type = "SEM"
          self.engine = "#{self.type}|no search engine"
          self.keyword = "#{self.type}|no search keyword"
          self.branded = "#{self.type}|Non-Brand"
          self.country = "#{self.type}|USA"
          self.tld = self.engine
          self.keyword_cloud = "#{self.type}|General"
          driver_name = "#{self.type}|#{els[0]}"
        elsif self.type == "External Websites"
          driver_name = "#{els[2]}|#{els[0]}" 
        elsif (self.type == "Social Media" || self.type == "SFDC Network")
          driver_name = "#{els[1]}|#{els[2]}|#{els[0]}" 
        else
          driver_name = "#{els[1]}|#{els[0]}"
        end
      elsif self.type == "External Websites"
        driver_name = els[1]
      elsif self.type == "Social Media" || self.type == "SFDC Network"
        driver_name = "#{self.type}|#{els[1]}"
      elsif self.type == "SEO"
        driver_name = "#{els[0]}|#{els[2]}"
      end
      
      driver_name
    end
    
    def get_keyword(els)
      return self.keyword if !self.keyword.nil?
      
      if els.count < 2 || !(self.type == "SEO" || self.type == "SEM")
        search_keyword = "" 
      elsif (self.type == "SEM" && els.count >= 3)
        search_keyword = els[3]
      else
        search_keyword = els[2]
      end
      
      search_keyword
    end
	
    def get_branded
      secure_flag = "no keyword (secure)"
      return_vals = ["Non-Brand", "Brand"]
      
      return default_search() if self.keyword == "" || self.keyword.nil?
      return (self.type + "|" + secure_flag) if self.keyword.include?(secure_flag)
      
      kw = self.keyword.downcase
      is_match = true
      brand_matches = BrandMatch.find(:all, order: "position")
      brand_matches.each do |bm|
        bm.match_list.downcase!
        matches = bm.match_list.split(",")
        is_match = true
        matches.each do |m|
          if !(("#{kw} ").include?("#{m} ") || (" #{kw}").include?(" #{m}"))
            # not a match
            is_match = false
            break
          elsif (m == matches.last) && (("#{kw} ").include?("#{m} ") || (" #{kw}").include?(" #{m}"))
            # check for an exclude list
            if !bm.exclude_list.nil?
              excludes = bm.exclude_list.split(",")
              excludes.each do |e|
                if ("#{kw} ").include?("#{e} ") || (" #{kw}").include?(" #{e}")
                  is_match = false
                  break
                end
              end
            end
          end
          
          break if is_match
        end
        break if is_match
      end
      
      self.type + "|" + return_vals[(is_match ? 1 : 0)]
    end
    
    def get_engine(els)
      return default_search if !(self.type == "SEO" || self.type == "SEM")
      
      search_engine = self.type == "SEM" ? els[2] : els[1]
      if search_engine.include?(" - ")
        search_engine = search_engine.slice(0, search_engine.index(" - ")).strip
      end
      
      search_engine = self.type + "|" + search_engine
	end
    
    def get_country(els)
      return default_search if !(self.type == "SEO" || self.type == "SEM")
      
      search_country = self.type == "SEM" ? els[2] : els[1]
	  search_country = search_country.gsub(self.type + "|", "")
	  if !search_country.include?(" - ")
	    search_country = "USA"
	  else
	    start = search_country.index(" - ") + 3
	    search_country = search_country.slice(start, search_country.length - start).strip
	  end
	  
	  search_country = "#{self.type}|#{search_country}"
    end
    
    def get_tld(els)
      return default_search if !(self.type == "SEO" || self.type == "SEM")
	  search_engine = self.type + "|" + (self.type == "SEM" ? els[2] : els[1])
    end
    
    def get_keyword_cloud
      default_cloud = "General"
      return default_search() if (self.keyword == "" || self.keyword.nil?)
      
      kw = self.keyword.downcase
      cloud = ""
      cloud_matches = CloudMatch.find(:all, order: "position")
      cloud_matches.each do |cm|
        cm.match_list.downcase!
        matches = cm.match_list.split(",")
        matches.each do |m|
          if !(("#{kw} ").include?("#{m} ") || (" #{kw}").include?(" #{m}"))
            break
          elsif (m == matches.last) && (("#{kw} ").include?("#{m} ") || (" #{kw}").include?(" #{m}"))
            cloud = cm.cloud.name
          end
        end
        break if cloud != ""
      end
      
      cloud = self.type + "|" + (cloud != "" ? cloud : default_cloud)
    end
    
    def get_display_country(els)
      return default_display() if self.type != "BAN"
      self.type + "|" + (els.length >= 3 ? els[2].upcase : "[NO COUNTRY SPECIFIED]")
    end
    
    def get_display_site(els)
      return default_display() if self.type != "BAN"
	  self.type + "|" + (els.length >= 4 ? els[3].upcase : "[NO PUBLISHER SPECIFIED]")
    end
    
    def get_display_product(els)
      return default_display() if self.type != "BAN"
	  self.type + "|" + (els.length >= 6 ? els[5].upcase : "[NO PRODUCT SPECIFIED]")
    end
    
    def get_display_date(els)
      return default_display() if self.type != "BAN"
	  self.type + "|" + (els.length >= 5 ? els[4].upcase : "[NO YEAR/QUARTER SPECIFIED]")
    end
    
    def get_driver_id(els)
      paid_types = ["SEM", "Other", "BAN", "Email"]
      unpaid_types = ["SEO", "Social Media", "External Websites", "SFDC Network"]
      
      drvr = default_62org
      drvr = els[0] if paid_types.include?(self.type)
      unpaid_types.each do |t|
        drvr = els[0] if (self.type == t && els[0] != t)
      end
      drvr
    end
end