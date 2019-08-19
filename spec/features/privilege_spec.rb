require "rails_helper"

RSpec.feature "Privilege" do
  context "As an unauthenticated user" do
    scenario "I can calculate my privilege score" do
      visit "/privileges"

      expect(page).to have_content I18n.t("privileges.index.optional")

      last_year = Time.zone.now.year - 1

      within ".simple_form" do
        select I18n.t("activerecord.attributes.privilege.salaries.thirty_five_to_fifty_five"), from: :privilege_salary
        select "Algeria", from: :privilege_country_code
        fill_in :privilege_year, with: 51
        fill_in :privilege_salary_year, with: last_year
        fill_in :privilege_role, with: "Chief tea maker"
        select I18n.t("activerecord.attributes.privilege.redundancies.once"), from: :privilege_redundancy

        page.find(".btn").click
      end

      privilege = Privilege.first.reload
      expect(privilege.salary).to eq "thirty_five_to_fifty_five"
      expect(privilege.country_code).to eq "DZ"
      expect(privilege.year).to eq 51
      expect(privilege.salary_year).to eq last_year
      expect(privilege.role).to eq  "Chief tea maker"
      expect(privilege.redundancy).to eq "once"

      within ".ability" do
        select I18n.t("categories.ability.a.answers.a"), from: :category_a
        select I18n.t("categories.ability.b.answers.b"), from: :category_b
        select I18n.t("categories.ability.c.answers.c"), from: :category_c
        select I18n.t("categories.ability.d.answers.a"), from: :category_d

        page.find(".btn").click
      end

      within ".caste" do
        select I18n.t("categories.caste.a.answers.d"), from: :category_a
        select I18n.t("categories.caste.b.answers.c"), from: :category_b
        select I18n.t("categories.caste.c.answers.b"), from: :category_c
        select I18n.t("categories.caste.d.answers.b"), from: :category_d

        page.find(".btn").click
      end

      within ".ethnicity" do
        select I18n.t("categories.ethnicity.a.answers.f"), from: :category_a
        select I18n.t("categories.ethnicity.b.answers.e"), from: :category_b
        select I18n.t("categories.ethnicity.c.answers.d"), from: :category_c
        select I18n.t("categories.ethnicity.d.answers.c"), from: :category_d
        select I18n.t("categories.ethnicity.e.answers.c"), from: :category_e

        page.find(".btn").click
      end

      within ".gender" do
        select I18n.t("categories.gender.a.answers.a"), from: :category_a
        select I18n.t("categories.gender.b.answers.b"), from: :category_b
        select I18n.t("categories.gender.c.answers.c"), from: :category_c

        page.find(".btn").click
      end

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
        select I18n.t("categories.gender.a.answers.c"), from: :category_a
        select I18n.t("categories.gender.b.answers.b"), from: :category_b
        select I18n.t("categories.gender.c.answers.b"), from: :category_c

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
      visit "/privileges"

      within ".simple_form" do
        page.find(".btn").click
      end

      within ".ability" do
        page.find(".btn").click
      end

      within ".caste" do
        page.find(".btn").click
      end

      within ".ethnicity" do
        page.find(".btn").click
      end

      within ".gender" do
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
  end
end
