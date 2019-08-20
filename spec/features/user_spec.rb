require "rails_helper"

RSpec.feature "User" do
  context "As an user" do
    scenario "I can sign up and sign in" do
      visit "/users/sign_up"

      within ".new_user" do
        fill_in :user_email, with: "user@dippy.com"
        fill_in :user_password, with: "123456"
        fill_in :user_password_confirmation, with: "123456"

        click_on "Sign up"
      end

      within ".flash" do
        expect(page).to have_content "Welcome! You have signed up successfully"
      end
    end
  end
end
