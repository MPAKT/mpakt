# frozen_string_literal: true

class PrivilegesController < ApplicationController
  def create
    @privilege.update(privilege_params)
    redirect_to privileges_path(privilege_id: @privilege.id)
  end

  def new; end

  def salaries
    redirect_to root_url, notice: t("errors.messages.not_authorized") unless current_user&.admin?
    salary_buckets
  end

  private

  def salary_buckets
    @salaries = []
    8.times do |index|
      subindex = 0
      percents = []
      Privilege.where(salary: index).map do |privilege|
        percents[subindex] = privilege.percent
        subindex += 1
      end
      @salaries[index] = percents.sort
    end
  end

  def privilege_params
    params.require(:privilege).permit(:salary, :year, :country_code, :redundancy, :role, :salary_year)
  end
end
