require 'spec_helper'

describe "Backend::Dashboards" do
  describe "should have the right titles" do
    before { visit backend_root_path }
    subject { page }

    it { should have_selector('title', text: "BenMayo.com") }
    it { should have_selector('title', text: ":: Dashboard") }
    it { should have_selector('h1', text: "BenMayo.com") }
  end

  describe "should have the right links" do
    it "and MrMayo should build a test for this"
  #   visit root_path
  #   click_link "About"
  #   page.should have_selector 'title', text: full_title('About Us')
  #   click_link "Help"
  #   page.should # fill in
  end
end