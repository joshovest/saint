require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/'
      page.should have_content('Sample App')
    end
  end
  
  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/help'
      page.should have_content('Help')
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/about'
      page.should have_content('About Us')
    end
  end
end
