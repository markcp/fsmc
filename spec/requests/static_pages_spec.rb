require 'spec_helper'

describe "Static pages" do

  describe "About page" do

    it "should have the content 'About'" do
      visit 'about'
      expect(page).to have_content('About')
    end
  end

  describe "Links page" do

    it "should have the content 'Links'" do
      visit '/links'
      expect(page).to have_content('Links')
    end
  end
end
