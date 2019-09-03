# frozen_string_literal: true

class PrivilegesController < ApplicationController
  def create
    @privilege = Privilege.create(privilege_params)
    redirect_to privileges_path(subtype: 0, privilege_id: @privilege.id)
  end

  def index
    @subtype = -1
    @subtype = params[:subtype].to_i if params[:subtype]
    @privilege_id = params[:privilege_id]
    @privilege = Privilege.find(@privilege_id) if @subtype > 3
  end

  def salaries
    redirect_to root_url, notice: t("errors.messages.not_authorized") unless current_user.admin?
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
