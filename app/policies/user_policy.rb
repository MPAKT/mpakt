# frozen_string_literal: true

class UserPolicy
  def self.manage?(current_user, user = null)
    return false unless current_user
    return true if current_user.admin?
    return false unless user

    return true if current_user == user
    false
  end
end
