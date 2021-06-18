# frozen_string_literal: true

class PrivilegesController < ApplicationController
  def create
    @privilege = Privilege.create(privilege_params)
    build_categories(@privilege.id)
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

  def build_categories(privilege_id)
    4.times do |index|
      Category.create(categories_params["category_#{index}"].merge(privilege_id: privilege_id))
    end
  end

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
    params.require(:privilege).permit(:salary, :year, :country_code, :redundancy, :role,
                                      :salary_year)
  end

  # rubocop:disable Naming/VariableNumber
  def categories_params
    params.require(:privilege).permit(category_0: %i[subtype a b c d],
                                      category_1: %i[subtype a b c d],
                                      category_2: %i[subtype a b c d e],
                                      category_3: %i[subtype a b c])
  end
  # rubocop:enable Naming/VariableNumber
end
