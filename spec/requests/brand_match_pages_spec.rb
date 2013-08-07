require 'spec_helper'

describe "Brand match pages" do
  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 10.times { FactoryGirl.create(:brand_match) } }
    after(:all)  { BrandMatch.delete_all }

    before(:each) do
      sign_in user
      visit brand_matches_path
    end

    describe "delete links" do

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit brand_matches_path
        end

        it { should have_link('delete', href: brand_match_path(BrandMatch.first)) }
        it "should be able to delete match" do
          expect { click_link('delete') }.to change(BrandMatch, :count).by(-1)
        end
      end
    end
  end
  
  describe "add match" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_brand_match_path
    end
        
    let(:submit) { "Add match" }

    describe "with invalid information" do
      it "should not create a match" do
        expect { click_button submit }.not_to change(BrandMatch, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "brand_match_match_list",		with: "Match 1"
      end

      it "should create a match" do
        expect { click_button submit }.to change(BrandMatch, :count).by(1)
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:brand_match) { FactoryGirl.create(:brand_match) }
    before do
      sign_in user
      visit edit_brand_match_path(brand_match)
    end

    describe "page" do
      it { should have_selector('title', text: "Change brand match") }
    end

    describe "with invalid information" do
      before do
        fill_in "brand_match_match_list", with: ""
        click_button "Save changes"
      end

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_list) { "matches\nnon-matches" }
      before do
        fill_in "brand_match_match_list",    	with: new_list
        click_button "Save changes"
      end
      
      it { should have_selector('div.alert.alert-success') }
      specify { brand_match.reload.match_list.should  == new_list.gsub("\n", ",") }
    end
  end
end