require 'spec_helper'

describe "Backend::Dashboards" do
  let(:base_title) { "BenMayo.com" }
  
  it "should have the content 'Benmayo.com'" do
    visit '/backend'
    page.should have_selector('h1', text: "#{base_title}")
  end
  
  it "should have the right title" do
    visit '/backend'
    page.should have_selector('title', text: "#{base_title} :: Dashboard")
  end
end
