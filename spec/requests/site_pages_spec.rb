require 'spec_helper'

describe "Site pages" do
  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 10.times { FactoryGirl.create(:site) } }
    after(:all)  { Site.delete_all }

    before(:each) do
      sign_in user
      visit sites_path
    end

    describe "delete links" do

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit sites_path
        end

        it { should have_link('delete', href: site_path(Site.first)) }
        it "should be able to delete site" do
          expect { click_link('delete') }.to change(Site, :count).by(-1)
        end
      end
    end
  end
  
  describe "add site" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_site_path
    end
        
    let(:submit) { "Add site" }

    describe "with invalid information" do
      it "should not create a site" do
        expect { click_button submit }.not_to change(Site, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "site_name",		with: "sitetest.com"
        fill_in "site_suite_list",  with: "salesforcesitetestcom\nsalesforcesitetestcom"
      end

      it "should create a site" do
        expect { click_button submit }.to change(Site, :count).by(1)
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:site) { FactoryGirl.create(:site) }
    before do
      sign_in user
      visit edit_site_path(site)
    end

    describe "page" do
      it { should have_selector('title', text: "Change site") }
    end

    describe "with invalid information" do
      before do
        fill_in "site_suite_list", with: ""
        click_button "Save changes"
      end

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name) { "sitetest1.com" }
      let(:new_suite_list) { "salesforcesitetest1com\nsalesforcesitetest1comdev" }
      before do
        fill_in "site_name",    	with: new_name
        fill_in "site_suite_list",  with: new_suite_list
        click_button "Save changes"
      end
      
      it { should have_selector('div.alert.alert-success') }
      specify { site.reload.name.should  == new_name }
      specify { site.reload.suite_list.should == new_suite_list.gsub("\n", ",") }
    end
  end
end