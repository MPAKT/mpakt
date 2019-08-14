# frozen_string_literal: true

module CollectionHelper

  def salary_collection
    Privilege.salaries.keys.map do |salary_range|
      [t(salary_range, scope: salary_range_scope), salary_range]
    end
  end

  def category_answers_collection(category_name, question_index)
    answers = answers_for_question(category_name, question_index)
    answers.map do |answer_index|
      puts answer_index
      puts I18n.t("categories.#{category_name}.#{question_index}.answers.#{answer_index}")
      [t(answer_index, scope: category_answer_scope(category_name, question_index)), answer_index]
    end
  end

  private

  def salary_range_scope
    "activerecord.attributes.privilege.salaries"
  end

  def category_answer_scope(category_name, question_index)
    "categories.#{category_name}.#{question_index}.answers"
  end

  def answers_for_question(category_name, question_index)
    if category_name == "ability"
      return ["a", "b"] if question_index == "d"
    end

    if category_name == "class"
      return ["a", "b", "c", "d"] unless question_index == "d"
    end
       
    ["a", "b", "c"]
  end
end
