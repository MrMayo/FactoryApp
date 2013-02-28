require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit backend_signin_path }
    
    it { should have_selector('title', text: full_title('Sign In')) }
    it { should have_selector('h1', text: 'Sign In') }
  end

  describe "signin" do
    before { visit backend_signin_path }

    describe "with valid information" do
      before { click_button "Sign In" }

      it { should have_selector('title', text: full_title('Sign In')) }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end
      it { should have_selector('title', text: full_title('Dashboard')) }
      it { should have_link('Sign Out', href: backend_signout_path) }
      it { should_not have_link('Sign In', href: backend_signin_path) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link('Sign In') }
      end
    end
  end
end
