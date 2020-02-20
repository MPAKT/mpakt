# frozen_string_literal: true

class PrivilegesController < ApplicationController
  def create
    @privilege = Privilege.create(privilege_params)
    redirect_to privilege_path(@privilege)
  end

  def new; end

  def show
    @privilege = Privilege.find(params[:id])
  end

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
    params.require(:privilege).permit(:salary, :year, :country_code, :redundancy, :role, :salary_year, categories: {})
  end
end
