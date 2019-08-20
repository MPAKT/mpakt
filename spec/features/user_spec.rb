require "rails_helper"

RSpec.feature "User" do
  context "As a user" do
    scenario "I can sign up and sign in" do
      visit "/"

      within ".menu" do
        click_on I18n.t("layouts.header.sign_in")
      end

      within ".devise-links" do
        click_on I18n.t("devise.shared.links.sign_up")
      end

      within ".new_user" do
        fill_in :user_email, with: "user@dippy.com"
        fill_in :user_password, with: "123456"
        fill_in :user_password_confirmation, with: "123456"

        click_on I18n.t("layouts.header.sign_up")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("devise.registrations.signed_up")
      end

      within ".menu" do
        click_on I18n.t("layouts.header.exit")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("devise.sessions.signed_out")
      end

      within ".menu" do
        click_on I18n.t("layouts.header.sign_in")
      end

      within ".new_user" do
        fill_in :user_email, with: "user@dippy.com"
        fill_in :user_password, with: "123456"

        click_on I18n.t("devise.sessions.new.sign_in")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("devise.sessions.signed_in")
      end
    end
  end
end
