require "rails_helper"

RSpec.feature "Homepage" do
  context "As an unauthenticated user" do
    scenario "I can see the welcome page" do
      visit "/"
      expect(page).to have_content I18n.t("welcome.index.subtitle")
    end
  end
end
