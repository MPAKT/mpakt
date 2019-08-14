# frozen_string_literal: true

module CollectionHelper

  def salary_collection
    Privilege.salaries.keys.map do |salary_range|
      [t(salary_range, scope: salary_range_scope), salary_range]
    end
  end

  private

  def salary_range_scope
    "activerecord.attributes.privilege.salaries"
  end

end
