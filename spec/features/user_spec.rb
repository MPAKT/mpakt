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
        fill_in :user_short_name, with: "shorty"
        fill_in :user_password, with: "123456"
        fill_in :user_password_confirmation, with: "123456"

        click_on I18n.t("layouts.header.sign_up")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("devise.registrations.signed_up")
      end

      user = User.first.reload
      expect(user.short_name).to eq "shorty"
      expect(user.moderator).to be false
      expect(user.admin).to be false

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

      visit "/users"

      within ".flash" do
        expect(page).to have_content I18n.t("errors.messages.not_authorized")
      end
    end
  end

  context "As an admin" do
    scenario "I can manage other users" do
      admin = User.create(email: "admin@dippy.com", password: "12346", short_name: "admin", moderator: true, admin: true)
      user = User.create(email: "user@dippy.com", password: "12346", short_name: "user")

      login_as admin
      visit "/"

      within ".menu" do
        click_on I18n.t("layouts.header.users")
      end

      #today = I18n.l(Time.zone.now.to_date, format: :short)
      within ".users" do
        rows = page.all("tr")
        expect(rows.count).to eq 2
        expect(rows[0]).to eq "admin@dippy.com admin true true"
      end
    end
  end

end
