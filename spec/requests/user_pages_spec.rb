require 'spec_helper'

describe "User pages" do
  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all)  { User.delete_all }

    before(:each) do
      sign_in user
      visit users_path
    end

    describe "pagination" do
      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('td', text: user.name)
        end
      end
    end
    
    describe "delete links" do

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
  
  describe "profile page" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit edit_user_path(admin)
    end
    
    it { should have_selector("title", text:"Update profile") }
  end
  
  describe "add user" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_user_path
    end
        
    let(:submit) { "Create user" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         	with: "Example User"
        fill_in "Email",        	with: "user@example.com"
        fill_in "Password",     	with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('title', text: "Update profile") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",				with: new_name
        fill_in "Email",			with: new_email
        fill_in "Password",			with: user.password
        fill_in "Confirm Password",	with: user.password
        click_button "Save changes"
      end
      
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
