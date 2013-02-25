require 'spec_helper'

describe "Backend::Dashboards" do
  before { visit backend_root_path }
  subject { page }

  it { should have_selector('h1', text: "BenMayo.com") }
  it { should have_selector('title', text: "BenMayo.com") }
  it { should have_selector('title', text: ":: Dashboard") }
end
