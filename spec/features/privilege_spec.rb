require "rails_helper"

RSpec.feature "Privilege" do
  context "As an unauthenticated user" do
    scenario "I can calculate my privilege score" do
      visit "/"

      within ".subsection" do
        click_on I18n.t("welcome.join.explore")
      end

      within ".wide" do
        click_on I18n.t("dashboard.dashboard.privilege")
      end

      expect(page).to have_content I18n.t("privileges.new.optional")

      last_year = Time.zone.now.year - 1

      within ".simple_form" do
        select I18n.t("activerecord.attributes.privilege.salaries.thirty_five_to_fifty_five"), from: :privilege_salary
        select "Algeria", from: :privilege_country_code
        fill_in :privilege_year, with: 51
        fill_in :privilege_salary_year, with: last_year
        select I18n.t("activerecord.attributes.privilege.roles.professional"), from: :privilege_role
        select I18n.t("activerecord.attributes.privilege.redundancies.once"), from: :privilege_redundancy
      end

      within ".ability" do
        select I18n.t("categories.ability.a.answers.a"), from: :privilege_category_0_a
        select I18n.t("categories.ability.b.answers.b"), from: :privilege_category_0_b
        select I18n.t("categories.ability.c.answers.c"), from: :privilege_category_0_c
        select I18n.t("categories.ability.d.answers.a"), from: :privilege_category_0_d
      end

      within ".caste" do
        select I18n.t("categories.caste.a.answers.d"), from: :privilege_category_1_a
        select I18n.t("categories.caste.b.answers.c"), from: :privilege_category_1_b
        select I18n.t("categories.caste.c.answers.b"), from: :privilege_category_1_c
        select I18n.t("categories.caste.d.answers.b"), from: :privilege_category_1_d
      end

      within ".ethnicity" do
        select I18n.t("categories.ethnicity.a.answers.f"), from: :privilege_category_2_a
        select I18n.t("categories.ethnicity.b.answers.e"), from: :privilege_category_2_b
        select I18n.t("categories.ethnicity.c.answers.d"), from: :privilege_category_2_c
        select I18n.t("categories.ethnicity.d.answers.c"), from: :privilege_category_2_d
        select I18n.t("categories.ethnicity.e.answers.c"), from: :privilege_category_2_e
      end

      within ".gender" do
        select I18n.t("categories.gender.a.answers.a"), from: :privilege_category_3_a
        select I18n.t("categories.gender.b.answers.b"), from: :privilege_category_3_b
        select I18n.t("categories.gender.c.answers.c"), from: :privilege_category_3_c
      end

      within ".new_privilege" do
        page.find(".btn").click
      end

      privilege = Privilege.first.reload
      expect(privilege.salary).to eq "thirty_five_to_fifty_five"
      expect(privilege.country_code).to eq "DZ"
      expect(privilege.year).to eq 51
      expect(privilege.salary_year).to eq last_year
      expect(privilege.role).to eq  "professional"
      expect(privilege.redundancy).to eq "once"

      ability_percent = 15 * 100 / 25
      within ".ability" do
        expect(page).to have_content "#{ability_percent}%"
      end

      caste_percent = 6 * 100 / 25
      within ".caste" do
        expect(page).to have_content "#{caste_percent}%"
      end

      ethnicity_percent = 5 * 100 / 25
      within ".ethnicity" do
        expect(page).to have_content "#{ethnicity_percent}%"
      end

      gender_percent = 12 * 100 / 25
      within ".gender" do
        expect(page).to have_content "#{gender_percent}%"
      end

      within ".overall" do
        total = ability_percent + caste_percent + ethnicity_percent + gender_percent
        percent = total / 4
        expect(page).to have_content "#{percent}%"
      end

      page.go_back

      within ".gender" do
        select I18n.t("categories.gender.a.answers.c"), from: :privilege_category_3_a
        select I18n.t("categories.gender.b.answers.b"), from: :privilege_category_3_b
        select I18n.t("categories.gender.c.answers.b"), from: :privilege_category_3_c
      end

      within ".new_privilege" do
        page.find(".btn").click
      end

      gender_percent = 0
      within ".gender" do
        expect(page).to have_content "#{gender_percent}%"
      end

      within ".overall" do
        total = ability_percent + caste_percent + ethnicity_percent + gender_percent
        percent = total / 4
        expect(page).to have_content "#{percent}%"
      end
    end

    scenario "I can leave all the fields blank" do
      visit "/privileges/new"

      within ".new_privilege" do
        page.find(".btn").click
      end

      within ".ability" do
        expect(page).to have_content "100%"
      end

      within ".caste" do
        expect(page).to have_content "100%"
      end

      within ".ethnicity" do
        expect(page).to have_content "100%"
      end

      within ".gender" do
        expect(page).to have_content "100%"
      end
    end

    scenario "I can not see the salary summary" do
      visit "/salaries"

      within ".flash" do
        expect(page).to have_content I18n.t("errors.messages.not_authorized")
      end
    end

  end

  context "As an authenticated user" do
    let(:user) { User.create(email: "user@mpakt.com", password: "123456", short_name: "user", last_sign_in_at: Time.zone.now) }
    scenario "I can not see the salary summary" do
      login_as user

      visit "/"

      within ".header" do
        expect(page).not_to have_content I18n.t("layouts.menu.salaries")
      end

      visit "/salaries"

      within ".flash" do
        expect(page).to have_content I18n.t("errors.messages.not_authorized")
      end
    end
  end

  context "As an authenticated admin" do
    let(:admin) { User.create(email: "admin@mpakt.com", password: "123456", short_name: "admin", volunteer: true, admin: true, last_sign_in_at: Time.zone.now) }

    scenario "I can see the salary summary" do
      privilege = Privilege.create(salary: 5)
      4.times do |index|
        Category.create(privilege_id: privilege.id, subtype: index, a: 2, b: 2, c: 2, d: 2)
      end

      login_as admin
      visit "/"

      within ".header" do
        click_on I18n.t("layouts.menu.salaries")
      end

      within ".salaries" do
        expect(page).to have_content "7.00 7.0 7 7 [7]"
      end
    end
  end

end
