require "rails_helper"

RSpec.feature "Ts and Cs" do
  include TranslationHelpers::StaticPages

  scenario "I can visit the terms and conditions page when logged out" do
    visit "/ts_and_cs"

    within ".policy" do
      expect_page_to_have_all_translations(
        scope: "policies.ts_and_cs",
        exclude_keys: [:legal_html]
      )

      expect(page).to have_content "By using our website, you acknowledge that you have read, understood and accept these Terms and Conditions of Use and that you agree to be bound by them."
    end
  end

  scenario "I can visit the cookies page when logged out" do
    visit "/cookies"

    within ".policy" do
      expect_page_to_have_all_translations(
        scope: "policies.cookies",
        exclude_keys: []
      )
    end
  end

  scenario "I can visit the data privacy page when logged out" do
    visit "/privacy"

    within ".policy" do
      expect_page_to_have_all_translations(
        scope: "policies.privacy",
        exclude_keys: [:us_1_html, :cookies_1_html]
      )

      expect(page).to have_content "This policy, together with our Terms and Conditions sets out the basis on which any data we collect from you, or that you provide to us, will be processed by us. Please read the following carefully to understand our views and practices regarding your personal data and how we will treat it. By visiting DIPpy you are accepting and consenting to the practices described in this policy."
      expect(page).to have_content "Our website uses cookies to distinguish you from other users of our website. This helps us to provide you with a good experience when you browse our website and also allows us to improve our site. For detailed information on the cookies we use and the purposes for which we use them see our Cookie policy"
    end
  end
end
