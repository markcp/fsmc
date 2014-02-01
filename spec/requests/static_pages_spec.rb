require 'spec_helper'

describe "Static pages" do

  describe "About page" do

    it "should have the content 'About'" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end
  end

  describe "Links page" do

    it "should have the content 'Links'" do
      visit '/static_pages/links'
      expect(page).to have_content('Links')
    end
  end
end
