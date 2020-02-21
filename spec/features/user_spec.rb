require "rails_helper"

RSpec.feature "User" do
  context "When signed out" do
    scenario "I can not view another user" do
      user = User.create(email: "user@mpakt.com", password: "123456", short_name: "user", last_sign_in_at: Time.zone.now)
      Profile.create(description: "User profile", user_id: user.id)

      visit "/"
      visit "/users/#{user.id}"

      expect(page).to have_content "You do not have access to that page"
      expect(page).not_to have_content "User profile"

      visit "/users/#{user.id}/edit"

      expect(page).to have_content "You need to sign in or sign up before continuing."
      expect(page).not_to have_content "User profile"
    end
  end

  context "As a new user" do
    scenario "I can sign up and sign in" do
      visit "/"

      within ".section" do
        click_on I18n.t("welcome.join.join")
      end

      within ".new_user" do
        fill_in :user_email, with: "new_user@mpakt.com"
        fill_in :user_short_name, with: "shorty"
        fill_in :user_password, with: "123456"
        fill_in :user_password_confirmation, with: "123456"

        click_on I18n.t("devise.registrations.new.sign_up")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("devise.registrations.signed_up")
      end

      expect(current_url).to have_content "dashboard"

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

      within ".section" do
        click_on I18n.t("welcome.join.sign_in")
      end

      within ".new_user" do
        fill_in :user_email, with: "new_user@mpakt.com"
        fill_in :user_password, with: "123456"

        click_on I18n.t("devise.sessions.new.sign_in")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("devise.sessions.signed_in")
      end

      expect(current_url).to have_content "dashboard"
    end
  end

  context "As a user" do
    let(:user) { User.create(email: "user@mpakt.com", password: "123456", short_name: "user", last_sign_in_at: Time.zone.now) }

    scenario "I can change my password" do
      login_as user
      visit "/"

      within ".menu" do
        click_on I18n.t("layouts.menu.card")
      end

      within ".edit_user" do
        fill_in :user_short_name, with: "changed"
        fill_in :user_current_password, with: "123456"
        fill_in :user_password, with: "654321"
        fill_in :user_password_confirmation, with: "654321"

        click_on I18n.t("users.form.save")
      end

      within ".flash" do
        expect(page).to have_content "Your account has been updated successfully."
      end

      within ".profile" do
        expect(page).to have_content "changed"
        expect(page).not_to have_content "user"
      end
    end

    scenario "I can edit my profile" do
      login_as user
      visit "/users/#{user.id}/edit"

      within ".edit_user" do
        fill_in :user_short_name, with: "changed"
        fill_in :profile_description, with: "New description"
        fill_in :profile_role, with: "My role"
        fill_in :profile_facebook, with: "Fb"
        fill_in :profile_instagram, with: "Insta"
        fill_in :profile_twitter, with: "@foo"
        fill_in :profile_url, with: "https://www.example.com"
        fill_in :profile_interests, with: "Underwater knitting"
        fill_in :profile_summary, with: "Summary contents"

        click_on I18n.t("users.form.save")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("users.update.success.", email: user.email)
      end

      within ".profile" do
        expect(page).to have_content "changed"
        expect(page).to have_content "New description"
        expect(page).to have_content "My role"
        expect(page).to have_content "Fb"
        expect(page).to have_content "Insta"
        expect(page).to have_content "@foo"
        expect(page).to have_content "https://www.example.com"
        expect(page).to have_content "Underwater knitting"
        expect(page).to have_content "Summary contents"
      end
    end

    scenario "I can view but not edit another profile" do
      login_as user

      another_user = User.create(email: "another@mpakt.com", password: "123456", short_name: "another",
                                 last_sign_in_at: Time.zone.now)
      Profile.create(description: "Another user profile", user_id: another_user.id)


      visit "/"
      visit "/users/#{another_user.id}"

      within ".profile" do
        expect(page).to have_content "Another user profile"
        expect(page).not_to have_link("", href: "/users/#{another_user.id}/edit")
      end

      visit "/users/#{another_user.id}/edit"

      expect(page).to have_content "You do not have access to that page"
    end

    scenario "I can not manage users, moderate or administer the forum" do
      login_as user

      user = User.create(email: "no_access_user@mpakt.com", password: "123456", short_name: "user", last_sign_in_at: Time.zone.now)
      Thredded::Messageboard.create!(name: "Test board")
      visit "/"

      within ".header" do
        expect(page).not_to have_content I18n.t("layouts.menu.users")
        click_on I18n.t("layouts.menu.forum")
      end

      within ".thredded--main-section" do
        expect(page).not_to have_content "Create a New Messageboard Group"
        expect(page).not_to have_content "Create a New Messageboard"
      end

      within ".thredded--navigation" do
        expect(page).not_to have_content "Moderation"
      end

      visit "/users"

      within ".flash" do
        expect(page).to have_content I18n.t("errors.messages.not_authorized")
      end
    end
  end

  context "As a moderator" do
    let(:moderator) { User.create(email: "moderator@mpakt.com", password: "123456", short_name: "moderator", last_sign_in_at: Time.zone.now, volunteer: true) }

    scenario "I can not manage users or forums, I can moderate posts" do
      login_as moderator

      user = User.create!(email: "another_user@mpakt.com", password: "123456", short_name: "user", last_sign_in_at: Time.zone.now)
      Thredded::Messageboard.create!(name: "Test board")
      visit "/"

      within ".header" do
        expect(page).not_to have_content I18n.t("layouts.menu.users")
        click_on I18n.t("layouts.menu.forum")
      end

      within ".thredded--main-section" do
        expect(page).not_to have_content "Create a New Messageboard Group"
        expect(page).not_to have_content "Create a New Messageboard"
      end

      within ".thredded--navigation" do
        expect(page).to have_content "Moderation"
      end

      visit "/users"

      within ".flash" do
        expect(page).to have_content I18n.t("errors.messages.not_authorized")
      end
    end
  end

  context "As an admin" do
    let(:admin) { User.create(email: "admin@mpakt.com", password: "123456", short_name: "admin", volunteer: true, admin: true, last_sign_in_at: Time.zone.now) }

    scenario "I can manage other users" do
      user = User.create(email: "other_user@mpakt.com", password: "123456", short_name: "user", last_sign_in_at: Time.zone.now)

      login_as admin
      visit "/"

      within ".header" do
        click_on I18n.t("layouts.menu.users")
      end

      today = I18n.l(Time.zone.now.to_date, format: :short)
      within ".users" do
        rows = page.all("tr")
        expect(rows.count).to eq 3
        expect(rows[1]).to have_content "admin@mpakt.com admin #{today}"
        expect(rows[2]).to have_content "other_user@mpakt.com user #{today}"
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

    scenario "I can administer and moderate the forums" do
      login_as admin
      visit "/forum"

      within ".thredded--main-section" do
        expect(page).to have_content "Create a New Messageboard Group"
        click_on "Create a New Messageboard"
      end

      within ".thredded--main-section" do
        fill_in :messageboard_name, with: "Test new message board"
        click_on "Create a New Messageboard"
      end

      within ".thredded--navigation" do
        expect(page).to have_content "Moderation"
      end
    end
  end
end
