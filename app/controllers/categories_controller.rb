# frozen_string_literal: true

class CategoriesController < ApplicationController
  def create
    remove_old_categories(category_params)
    old_subtype_id = Category.subtypes[category_params[:subtype]]
    @category = Category.create(category_params) if old_subtype_id < 4
    redirect_to privileges_path(subtype: old_subtype_id + 1, privilege_id: category_params[:privilege_id])
  end

  private

  # We can get here if the user uses the back button to get to a previous category.
  # If so, destroy any existing categories for this privilege and subtype, and then save the new one as usual
  # It would be more proper to have an update route and method, but update is not expected during normal flow and we
  # don't set the category id on the form for any other reason, so it feels like overkill just to cater for back button
  def remove_old_categories(category_params)
    Category.find_by(privilege_id: category_params[:privilege_id], subtype: category_params[:subtype])&.destroy
  end

  def category_params
    params.require(:category).permit(:subtype, :a, :b, :c, :d, :e, :privilege_id)
  end
end
