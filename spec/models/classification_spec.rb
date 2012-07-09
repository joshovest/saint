require 'spec_helper'

describe Classification do
  # must load a few brand/cloud matches
  before do
    bm1 = BrandMatch.new(match_list: "salesforce").save
    bm2 = BrandMatch.new(match_list: "force.com").save
    bm3 = BrandMatch.new(match_list: "dreamforce").save
    bm4 = BrandMatch.new(match_list: "sales force", exclude_list: "sales force automation").save
    bm5 = BrandMatch.new(match_list: "chatter").save
    bm6 = BrandMatch.new(match_list: "collaboration cloud").save
    
    c1 = Cloud.new(name: "Sales Cloud")
    c1.save
    cm1 = CloudMatch.new(match_list: "sales,automation", cloud_id: c1.id).save
    
    c2 = Cloud.new(name: "Collaboration Cloud")
    c2.save
    cm2 = CloudMatch.new(match_list: "social software", cloud_id: c2.id).save
  end

  describe "test SEO classification (US/Google/no keyword)" do
    before do
      @c = Classification.new(key: "SEO|Google|no keyword (secure)")
    end
    subject { @c }
    
    its(:type)				{ should == "SEO" }
    its(:engine)			{ should == "SEO|Google" }
    its(:tld)				{ should == "SEO|Google" }
    its(:name)				{ should == "SEO|no keyword (secure)" }
    its(:country)			{ should == "SEO|USA" }
    its(:branded)			{ should == "SEO|no keyword (secure)" }
    its(:keyword_cloud)		{ should == "SEO|General" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test SEO classification (US/Google/keyword)" do
    before do
      @c = Classification.new(key: "SEO|Google|salesforce")
    end
    subject { @c }
    
    its(:type)				{ should == "SEO" }
    its(:engine)			{ should == "SEO|Google" }
    its(:tld)				{ should == "SEO|Google" }
    its(:name)				{ should == "SEO|salesforce" }
    its(:country)			{ should == "SEO|USA" }
    its(:branded)			{ should == "SEO|Brand" }
    its(:keyword_cloud)		{ should == "SEO|General" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test SEO classification (US/Bing/keyword)" do
    before do
      @c = Classification.new(key: "SEO|Microsoft Bing|sales force automation")
    end
    subject { @c }
    
    its(:type)				{ should == "SEO" }
    its(:engine)			{ should == "SEO|Microsoft Bing" }
    its(:tld)				{ should == "SEO|Microsoft Bing" }
    its(:name)				{ should == "SEO|sales force automation" }
    its(:country)			{ should == "SEO|USA" }
    its(:branded)			{ should == "SEO|Non-Brand" }
    its(:keyword_cloud)		{ should == "SEO|Sales Cloud" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test SEO classification (Canada/keyword)" do
    before do
      @c = Classification.new(key: "SEO|Google - Canada|dreamforce")
    end
    subject { @c }
    
    its(:type)				{ should == "SEO" }
    its(:engine)			{ should == "SEO|Google" }
    its(:tld)				{ should == "SEO|Google - Canada" }
    its(:name)				{ should == "SEO|dreamforce" }
    its(:country)			{ should == "SEO|Canada" }
    its(:branded)			{ should == "SEO|Brand" }
    its(:keyword_cloud)		{ should == "SEO|General" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test SEO classification (Italy/keyword)" do
    before do
      @c = Classification.new(key: "SEO|Yahoo! - Italy|pricing")
    end
    subject { @c }
    
    its(:type)				{ should == "SEO" }
    its(:engine)			{ should == "SEO|Yahoo!" }
    its(:tld)				{ should == "SEO|Yahoo! - Italy" }
    its(:name)				{ should == "SEO|pricing" }
    its(:country)			{ should == "SEO|Italy" }
    its(:branded)			{ should == "SEO|Non-Brand" }
    its(:keyword_cloud)		{ should == "SEO|General" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test SEO classification (Spain/keyword)" do
    before do
      @c = Classification.new(key: "SEO|Yahoo! - Spain|social software")
    end
    subject { @c }
    
    its(:type)				{ should == "SEO" }
    its(:engine)			{ should == "SEO|Yahoo!" }
    its(:tld)				{ should == "SEO|Yahoo! - Spain" }
    its(:name)				{ should == "SEO|social software" }
    its(:country)			{ should == "SEO|Spain" }
    its(:branded)			{ should == "SEO|Non-Brand" }
    its(:keyword_cloud)		{ should == "SEO|Collaboration Cloud" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test SFDC Network + driver" do
    before do
      @c = Classification.new(key: "70130000000sbz6AAA|SFDC Network|[www.salesforce.com]")
    end
    subject { @c }
    
    its(:type)				{ should == "SFDC Network" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "SFDC Network|[www.salesforce.com]|70130000000sbz6AAA" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "70130000000sbz6AAA" }
    	
    it { should be_valid }
  end
  
  describe "test SFDC Network" do
    before do
      @c = Classification.new(key: "SFDC Network|[Community Site]")
    end
    subject { @c }
    
    its(:type)				{ should == "SFDC Network" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "SFDC Network|[Community Site]" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test SEM classification (US/keyword)" do
    before do
      @c = Classification.new(key: "70130000000sjIUAAY|SEM|Google|salesforce.com")
    end
    subject { @c }
    
    its(:type)				{ should == "SEM" }
    its(:engine)			{ should == "SEM|Google" }
    its(:tld)				{ should == "SEM|Google" }
    its(:name)				{ should == "SEM|70130000000sjIUAAY" }
    its(:country)			{ should == "SEM|USA" }
    its(:branded)			{ should == "SEM|Brand" }
    its(:keyword_cloud)		{ should == "SEM|General" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "70130000000sjIUAAY" }
    	
    it { should be_valid }
  end
  
  describe "test SEM classification (US/no keyword)" do
    before do
      @c = Classification.new(key: "70130000000EefoAAC|SEM|no search engine|no keyword")
    end
    subject { @c }
    
    its(:type)				{ should == "SEM" }
    its(:engine)			{ should == "SEM|no search engine" }
    its(:tld)				{ should == "SEM|no search engine" }
    its(:name)				{ should == "SEM|70130000000EefoAAC" }
    its(:country)			{ should == "SEM|USA" }
    its(:branded)			{ should == "SEM|Non-Brand" }
    its(:keyword_cloud)		{ should == "SEM|General" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "70130000000EefoAAC" }
    	
    it { should be_valid }
  end
  
  describe "test BAN classification" do
    before do
      @c = Classification.new(key: "70130000000siZ8AAI|BAN|us|adroll|fy13q2|data.com")
    end
    subject { @c }
    
    its(:type)				{ should == "BAN" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "BAN|70130000000siZ8AAI" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "BAN|US" }
    its(:display_site)		{ should == "BAN|ADROLL" }
    its(:display_product)	{ should == "BAN|DATA.COM" }
    its(:display_date)		{ should == "BAN|FY13Q2" }
    its(:driver_id)			{ should == "70130000000siZ8AAI" }
    	
    it { should be_valid }
  end
  
  describe "test email classification" do
    before do
      @c = Classification.new(key: "70130000000sivOAAQ|Email")
    end
    subject { @c }
    
    its(:type)				{ should == "Email" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "Email|70130000000sivOAAQ" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "70130000000sivOAAQ" }
    	
    it { should be_valid }
  end
  
  describe "test social media classification" do
    before do
      @c = Classification.new(key: "Social Media|facebook")
    end
    subject { @c }
    
    its(:type)				{ should == "Social Media" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "Social Media|facebook" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test social media classification + driver" do
    before do
      @c = Classification.new(key: "70130000000shhaAAA|Social Media|linkedin")
    end
    subject { @c }
    
    its(:type)				{ should == "Social Media" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "Social Media|linkedin|70130000000shhaAAA" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "70130000000shhaAAA" }
    	
    it { should be_valid }
  end
  
  describe "test external website classification" do
    before do
      @c = Classification.new(key: "External Websites|www.google.com")
    end
    subject { @c }
    
    its(:type)				{ should == "External Websites" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "www.google.com" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "[NON-62 ORG TRAFFIC DRIVER]" }
    	
    it { should be_valid }
  end
  
  describe "test external website classification + driver" do
    before do
      @c = Classification.new(key: "70130000000siC9AAI|External Websites|googleads.g.doubleclick.net")
    end
    subject { @c }
    
    its(:type)				{ should == "External Websites" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "googleads.g.doubleclick.net|70130000000siC9AAI" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "70130000000siC9AAI" }
    	
    it { should be_valid }
  end
  
  describe "test otherclassification" do
    before do
      @c = Classification.new(key: "70130000000siBBAAY|Other")
    end
    
    subject { @c }
    
    its(:type)				{ should == "Other" }
    its(:engine)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:tld)				{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:name)				{ should == "Other|70130000000siBBAAY" }
    its(:country)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:branded)			{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:keyword_cloud)		{ should == "[NON-SEARCH TRAFFIC DRIVER]" }
    its(:display_country)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_site)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_product)	{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:display_date)		{ should == "[NON-BANNER TRAFFIC DRIVER]" }
    its(:driver_id)			{ should == "70130000000siBBAAY" }
    	
    it { should be_valid }
  end
end
