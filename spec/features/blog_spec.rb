require "rails_helper"

RSpec.feature "Blog" do

  context "As an admin" do
    let(:admin) { User.create(email: "blog_admin@mpact.com", password: "123456", short_name: "blog_admin", volunteer: true, admin: true, last_sign_in_at: Time.zone.now) }

    scenario "I can create and manage blog posts" do
      login_as admin

      visit "/"

      within ".header" do
        click_on I18n.t("layouts.header.blog")
      end

      within ".main" do
        click_on I18n.t("blogs.index.create")
      end

      within ".new_blog" do
        fill_in :blog_title, with: "Test title"
        fill_in :blog_summary, with: "Summary test"
        click_on I18n.t("blogs.form.submit")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("success.create", name: "Test title")
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

      within ".flash" do
        expect(page).to have_content I18n.t("success.update", name: "Test title")
      end

      within ".blog" do
        expect(page).to have_content "Test title"
        expect(page).to have_content "Edited"
        expect(page).not_to have_content "Summary test"
      end

      within ".right" do
        click_on I18n.t("blogs.show.back")
      end

      within ".blogs" do
        expect(page).to have_content "Edited"
        expect(page).to have_content "Test title"

        click_on "Test title"
      end

      within ".right" do
        click_on I18n.t("blogs.show.edit")
      end

      within ".right" do
        click_on I18n.t("blogs.edit.delete")
      end

      within ".flash" do
        expect(page).to have_content I18n.t("success.delete", name: "Test title")
      end

      within ".blogs" do
        expect(page).not_to have_content "Edited"
        expect(page).not_to have_content "Test title"
      end

    end
  end

  context "As an user" do
    let(:user) { User.create(email: "blog@mpact.com", password: "123456", short_name: "blog", last_sign_in_at: Time.zone.now) }

    scenario "I can not edit blog posts" do
      login_as user

      visit "/blogs"

      expect(page).not_to have_content I18n.t("blogs.index.create")

      visit "/blogs/new"

      within ".flash" do
        expect(page).to have_content I18n.t("errors.messages.not_authorized")
      end
    end
  end
end
