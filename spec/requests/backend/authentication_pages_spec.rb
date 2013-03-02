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

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_backend_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end

        describe "after signing in" do
          it "should render the desired protected bage" do
            page.should have_selector('title', text: 'Edit User')
          end
        end
      end

      it "has a tag right here to check later 9.2.1"
      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_backend_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "submitting to the update action" do
          before { put backend_user_path(user) }
          specify { response.should redirect_to(backend_signin_path) }
        end

        describe "visiting the user index" do
          before { visit backend_users_path }
          it { should have_selector('title', text: 'Sign In') }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_backend_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit User')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put backend_user_path(wrong_user) }
        specify { response.should redirect_to(backend_root_path) }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before { sign_in user }

        it { should have_selector('title', text: 'Dashboard') }
        it "{ should have a bunch of links }"
      end

      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }
        before { sign_in non_admin }

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete backend_user_path(user) }
          specify { response.should redirect_to(backend_root_path) }
        end
      end
    end
  end
end