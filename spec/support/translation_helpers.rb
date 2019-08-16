module TranslationHelpers
  module General
    def t(*args)
      I18n.t(args)
    end

    def l(*args)
      I18n.l(args)
    end
  end

  module StaticPages
    # Useful for static pages, make sure all translated content is shown on the page.
    #
    # For translations that include dynamic placeholders you can choose to truncate the
    # expected to only look at certain number of characters at the beginning of the content,
    # for example:
    #  ```
    #  expect_page_to_have_all_translations(scope: "privacy_policy.show", truncate_keys: { info_3: 30 })
    # ```
    # Would only try and find the first 30 characters of the `privacy_policy.show.info_3` translation.
    #
    # `scope` if the I18n scope to look up the keys.
    def expect_page_to_have_all_translations(scope:, truncate_keys: {}, exclude_keys: [])
      keys_to_exclude = Array(exclude_keys)
      i18n_keys = I18n.t(scope).keys

      expect(i18n_keys).not_to be_empty

      i18n_keys.each do |key|
        next if keys_to_exclude.include?(key)

        content =
          if truncate_keys.keys.include?(key)
            amount = truncate_keys[key]

            I18n.t(key, scope: scope).first(amount)
          else
            I18n.t(key, scope: scope)
          end

        expect(page).to have_content(content), error_message(scope, key, content)
      end
    end

    private

    def error_message(scope, key, content)
      missing_content_error = <<~ERROR
      Cannot find translation on page: #{scope}.#{key}
      Searching for content:
      #{'-' * [content.length, 300].min}
      #{content}
      #{'-' * [content.length, 300].min}
    ERROR

      if content.include?("%{")
        missing_content_error + placeholder_error(scope, key, content)
      else
        missing_content_error
      end
    end

    def placeholder_error(scope, key, content)
      placeholder_match = content.match(/%{.+}/)
      safe_index = placeholder_match.pre_match.length

      <<~ERROR
      You are using a placeholder #{placeholder_match}, either exclude this key from the list of translations
      to search for and write a separate expectation that fill in the value:
      ```
      expect_page_to_have_all_translations(scope: "#{scope}", exclude_keys: :#{key} })
      expect(page).to have_content(I18n.t("#{scope}.#{key}", #{placeholder_match}: some_value))
      ```
      Or truncate the amount of content that this method will assert exists on the page:
      ```
      expect_page_to_have_all_translations(scope: "#{scope}", truncate_keys: { #{key}: #{safe_index} })
      ```
      The truncation amount is accurate for this content.
    ERROR
    end
  end
end
