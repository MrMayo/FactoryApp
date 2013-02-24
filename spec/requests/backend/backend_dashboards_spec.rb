require 'spec_helper'

describe "Backend::Dashboards" do
  it "should have the content 'Benmayo.com'" do
    visit '/backend'
    page.should have_selector('h1', text: "BenMayo.com")
  end
  
  it "should have the right title" do
    visit '/backend'
    page.should have_selector('title', text: "BenMayo.com :: Dashboard")
  end
end
