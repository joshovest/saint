require 'spec_helper'

describe "Cloud pages" do
  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 10.times { FactoryGirl.create(:cloud) } }
    after(:all)  { Cloud.delete_all }

    before(:each) do
      sign_in user
      visit clouds_path
    end

    describe "delete links" do

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit clouds_path
        end

        it { should have_link('delete', href: cloud_path(Cloud.first)) }
        it "should be able to delete cloud" do
          expect { click_link('delete') }.to change(Cloud, :count).by(-1)
        end
      end
    end
  end
  
  describe "add cloud" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_cloud_path
    end
        
    let(:submit) { "Add cloud" }

    describe "with invalid information" do
      it "should not create a cloud" do
        expect { click_button submit }.not_to change(Cloud, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "cloud_name",		with: "Cloud 1"
      end

      it "should create a cloud" do
        expect { click_button submit }.to change(Cloud, :count).by(1)
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:cloud) { FactoryGirl.create(:cloud) }
    before do
      sign_in user
      visit edit_cloud_path(cloud)
    end

    describe "page" do
      it { should have_selector('title', text: "Change cloud") }
    end

    describe "with invalid information" do
      before do
        fill_in "cloud_name", with: ""
        click_button "Save changes"
      end

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name) { "Cloud 2" }
      before do
        fill_in "cloud_name",    	with: new_name
        click_button "Save changes"
      end
      
      it { should have_selector('div.alert.alert-success') }
      specify { cloud.reload.name.should  == new_name }
    end
  end
end