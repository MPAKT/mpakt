require "rails_helper"

RSpec.feature "User" do
  context "As a user" do
    scenario "I can sign up and sign in" do
      visit "/"

      within ".header" do
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
      expect(user.volunteer).to be false
      expect(user.admin).to be false

      within ".header" do
        click_on I18n.t("layouts.header.exit")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("devise.sessions.signed_out")
      end

      within ".header" do
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
      user = User.create(email: "user@dippy.com", password: "123456", short_name: "user", last_sign_in_at: Time.zone.now)
      admin = User.create(email: "admin@dippy.com", password: "123456", short_name: "admin", volunteer: true, admin: true, last_sign_in_at: Time.zone.now)

      login_as admin
      visit "/"

      within ".header" do
        click_on I18n.t("layouts.header.users")
      end

      today = I18n.l(Time.zone.now.to_date, format: :short)
      within ".users" do
        rows = page.all("tr")
        expect(rows.count).to eq 3
        expect(rows[1]).to have_content "admin@dippy.com admin #{today}"
        expect(rows[2]).to have_content "user@dippy.com user #{today}"
      end

      within ".user-#{admin.id}" do
        admin_status = page.find("#user_admin")
        expect(admin_status).to be_checked
        moderator_status = page.find("#user_volunteer")
        expect(moderator_status).to be_checked
      end

      within ".user-#{user.id}" do
        admin_status = page.find("#user_admin")
        expect(admin_status).not_to be_checked
        moderator_status = page.find("#user_volunteer")
        expect(moderator_status).not_to be_checked

        moderator_status.set true
        click_on I18n.t("users.index.save")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("users.update.success", email: user.email)
      end

      within ".user-#{user.id}" do
        moderator_status = page.find("#user_volunteer")
        expect(moderator_status).to be_checked
      end
    end
  end
end
