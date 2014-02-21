require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

  describe "Links page" do

    before { visit links_path }
    let(:heading) { 'Links' }
    let(:page_title) { 'Link' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Links"
    expect(page).to have_title(full_title('Links'))
  end
end
