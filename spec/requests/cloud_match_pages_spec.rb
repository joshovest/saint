require 'spec_helper'

describe "Cloud match pages" do
  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) do
      FactoryGirl.create(:cloud)
      10.times { FactoryGirl.create(:cloud_match) }
    end
    after(:all)  { CloudMatch.delete_all }

    before(:each) do
      sign_in user
      visit cloud_matches_path
    end

    describe "delete links" do

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit cloud_matches_path
        end

        it { should have_link('delete', href: cloud_match_path(CloudMatch.first)) }
        it "should be able to delete match" do
          expect { click_link('delete') }.to change(CloudMatch, :count).by(-1)
        end
      end
    end
  end
  
  describe "add match" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:cloud) { FactoryGirl.create(:cloud) }
    
    before do
      sign_in admin
      visit new_cloud_match_path
    end
        
    let(:submit) { "Add match" }

    describe "with invalid information" do
      it "should not create a match" do
        expect { click_button submit }.not_to change(CloudMatch, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "cloud_match_match_list",		with: "Match 1"
        select Cloud.first.name, :from => "cloud_match[cloud_id]"

      end

      it "should create a match" do
        expect { click_button submit }.to change(CloudMatch, :count).by(1)
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:cloud) { FactoryGirl.create(:cloud) }
    let(:cloud_match) { FactoryGirl.create(:cloud_match) }
    before do
      sign_in user
      visit edit_cloud_match_path(cloud_match)
    end

    describe "page" do
      it { should have_selector('title', text: "Change cloud match") }
    end

    describe "with invalid information" do
      before do
        fill_in "cloud_match_match_list", with: ""
        click_button "Save changes"
      end

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_list) { "matches\nnon-matches" }
      before do
        fill_in "cloud_match_match_list",    	with: new_list
        click_button "Save changes"
      end
      
      it { should have_selector('div.alert.alert-success') }
      specify { cloud_match.reload.match_list.should  == new_list.gsub("\n", ",") }
    end
  end
end