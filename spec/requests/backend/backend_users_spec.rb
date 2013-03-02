require 'spec_helper'

describe "Backend::User Pages" do
  subject { page }

  describe "User Index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit backend_users_path
    end

    it { should have_selector('h1',    text: 'User List') }
    it { should have_selector('title', text: 'User List') }

    describe "pagination" do
      before(:all) { 30.times {FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      it { should have_selector('nav.pagination') }
    end

    describe "delete links" do
      it { should_not have_link('delete') }
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit backend_users_path
        end

        it { should have_link('Delete', href: backend_user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('Delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('Delete', href: backend_user_path(admin)) }
      end
    end
  end

  describe "User New" do
    before { visit new_backend_user_path }

    it { should have_selector('title', text: full_title('New User')) }
    it { should have_selector('h1', text: 'New User') }
    
    it "should have the right links"
    #   click_link 'Index'
    #   page.should have_selector('title', text: 'User List')
    # end

    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before { click_button submit }
        it { should have_selector('title', text: full_title('New User')) }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "User@Example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }
        it { should have_selector('title', text: 'User Page') }
        it { should have_selector('div.alert.alert-notice', text: 'User was successfully created.') }
        it { should have_link('Sign Out') }
      end
    end
  end

  describe "User Show" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit backend_user_path(user) }

    it { should have_selector('title', text: full_title('User Page')) }
    it { should have_selector('h1', text: user.name) }
  end

  describe "User Edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_backend_user_path(user)
    end

    it { should have_selector('title', text: full_title('Edit User')) }
    it { should have_selector('h1', text: user.name) }

    describe "with invalid information" do
      before { click_button "Update User" }
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Update User"
      end
      it { should have_selector('h1', text: new_name) }
      it { should have_selector('div.alert.alert-notice') }
      it { should have_link('Sign Out', href: backend_signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end