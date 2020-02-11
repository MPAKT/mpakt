require "rails_helper"

RSpec.feature "Landing page" do
  context "As an unauthenticated user" do
    scenario "I can see the welcome page" do
      visit "/"
      expect(page).to have_content I18n.t("welcome.titles.subtitle")
      expect(page).to have_content I18n.t("welcome.titles.share")
      expect(page).to have_content I18n.t("welcome.index.join")
      expect(page).to have_content I18n.t("welcome.index.sign_in")
      expect(page).to have_content I18n.t("welcome.index.explore")

    end
  end
end
