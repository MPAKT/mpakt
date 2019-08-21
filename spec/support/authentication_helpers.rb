# frozen_string_literal: true

module AuthenticationHelpers
  module General

    def login_as(user, opts = {})
      opts.reverse_merge!(scope: user&.model_name&.element)

      Warden.on_next_request do |proxy|
        opts[:event] ||= :authentication
        proxy.set_user(user, opts)
      end
    end
  end
end
