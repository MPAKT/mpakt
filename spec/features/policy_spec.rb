require "rails_helper"

RSpec.feature "Ts and Cs" do
  include TranslationHelpers::StaticPages

  scenario "I can visit the terms and conditions page when logged out" do
    visit "/"

    within ".footer" do
      click_on I18n.t("layouts.footer.ts_and_cs")
    end

    within ".policy" do
      expect_page_to_have_all_translations(
        scope: "policies.ts_and_cs",
        exclude_keys: [:legal_html]
      )

      expect(page).to have_content "By using our website, you acknowledge that you have read, understood and accept these Terms and Conditions of Use and that you agree to be bound by them."
    end
  end

end
