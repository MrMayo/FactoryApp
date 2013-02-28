require 'spec_helper'

describe "Backend::User Pages" do
  subject { page }

  describe "User New" do
    before { visit new_backend_user_path }

    it { should have_selector('title', text: full_title('New User')) }
    it { should have_selector('h1', text: 'New User') }

    it "should have the right links" do
      click_link 'Index'
      page.should have_selector('title', text: 'User List')
    end

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

    it "should have the right links" do
      click_link 'Index'
      page.should have_selector('title', text: 'User List')
      click_link 'Edit'
      page.should have_selector('title', text: 'Edit User')
    end
  end
end