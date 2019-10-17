require "rails_helper"

RSpec.feature "Blog" do

  context "As an admin" do
    let(:admin) { User.create(email: "admin@dippy.com", password: "123456", short_name: "admin", volunteer: true, admin: true, last_sign_in_at: Time.zone.now) }

    scenario "I can create and manage blog posts" do
      login_as admin

      visit "/blogs"

      within ".right" do
        click_on I18n.t("blogs.index.create")
      end

      within ".new_blog" do
        fill_in :blog_title, with: "Test title"
        fill_in :blog_summary, with: "Summary test"
        click_on I18n.t("blogs.form.submit")
      end

      within ".blog" do
        expect(page).to have_content "Test title"
        expect(page).to have_content "Summary test"
      end

      within ".right" do
        click_on I18n.t("blogs.show.edit")
      end

      within ".edit_blog" do
        fill_in :blog_summary, with: "Edited"
        click_on I18n.t("blogs.form.submit")
      end

      within ".blog" do
        expect(page).to have_content "Edited"
        expect(page).not_to have_content "Summary test"
      end

      within ".right" do
        click_on I18n.t("blogs.show.back")
      end

      within ".blogs" do
        expect(page).to have_content "Edited"
        expect(page).to have_content "Test title"
      end
    end
  end
end
