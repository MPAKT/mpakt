# frozen_string_literal: true

class CategoriesController < ApplicationController
  def create
    old_subtype_id = Category.subtypes[category_params[:subtype]]
    @category = Category.create(category_params) if old_subtype_id < 4
    redirect_to privileges_path(subtype: old_subtype_id + 1, privilege_id: category_params[:privilege_id])
  end

  private

  def category_params
    params.require(:category).permit(:subtype, :a, :b, :c, :d, :e, :privilege_id)
  end
end
