require 'spec_helper'

describe "Backend::User Pages" do
  subject { page }

  describe "User New" do
    before { visit new_backend_user_path }

    it { should have_selector('title', text: full_title('New User')) }
    it { should have_selector('h1', text: 'New User') }

    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
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
    end

    it "should have the right links"
    # click_link "Edit"
    # it { should have_selector('title', text: full_title('Edit User')) }
    # click_link "Back"
    # it { should have_selector('title', text: full_title('User Index')) }
  end

  describe "User Show" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit backend_user_path(user) }

    it { should have_selector('title', text: full_title('User Page')) }
    it { should have_selector('h1', text: user.name) }
  end
end