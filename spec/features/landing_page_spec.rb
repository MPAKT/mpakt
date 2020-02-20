require "rails_helper"

RSpec.feature "Landing page" do
  context "As an unauthenticated user" do
    scenario "I can see the welcome page" do
      visit "/"
      expect(page).to have_content I18n.t("welcome.titles.subtitle")
      expect(page).to have_content I18n.t("welcome.titles.share")
      expect(page).to have_content I18n.t("welcome.join.join")
      expect(page).to have_content I18n.t("welcome.join.sign_in")
      expect(page).to have_content I18n.t("welcome.join.explore")

      expect(page).not_to have_content I18n.t("layouts.menu.forum")
      expect(page).not_to have_content I18n.t("layouts.menu.blog")
      expect(page).not_to have_content I18n.t("layouts.menu.users")
    end
  end
end
