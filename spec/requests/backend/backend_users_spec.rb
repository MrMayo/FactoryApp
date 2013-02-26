require 'spec_helper'

describe "Backend::User Pages" do
  subject { page }

  describe "Backend::User New" do
    before { visit new_backend_user_path }

    it { should have_selector('h1',    text: 'New User') }
    it { should have_selector('title', text: full_title('New User')) }
  end
end