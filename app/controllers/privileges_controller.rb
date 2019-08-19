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

  private

  def privilege_params
    params.require(:privilege).permit(:salary, :year, :country_code, :redundancy, :role, :salary_year)
  end
end
