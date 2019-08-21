# frozen_string_literal: true

class UserPolicy
  def self.manage?(current_user)
    return true if current_user.admin?
    false
  end
end
