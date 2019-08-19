# frozen_string_literal: true

module PrivilegeHelper
  def salary_collection
    Privilege.salaries.keys.map do |salary_range|
      [t(salary_range, scope: salary_range_scope), salary_range]
    end
  end

  def redundancy_collection
    Privilege.redundancies.keys.map do |redundancy_category|
      [t(redundancy_category, scope: redundancy_category_scope), redundancy_category]
    end
  end

  def category_answers_collection(category_name, question_index)
    answers = answers_for_question(category_name, question_index)
    answers.each_with_index.map do |answer_index, index|
      [t(answer_index, scope: category_answer_scope(category_name, question_index)), index]
    end
  end

  private

  def salary_range_scope
    "activerecord.attributes.privilege.salaries"
  end

  def redundancy_category_scope
    "activerecord.attributes.privilege.redundancies"
  end

  def category_answer_scope(category_name, question_index)
    "categories.#{category_name}.#{question_index}.answers"
  end

  def answers_for_question(category_name, question_index)
    answers = custom_answers_for_question(category_name, question_index)
    return answers if answers

    %w[a b c]
  end

  def custom_answers_for_question(category_name, question_index)
    # Ability doesn't feature in this list because currently all the ability questions have
    # the default number of options (three).
    case category_name
    when "caste"
      answers_for_caste(question_index)
    when "ethnicity"
      answers_for_ethnicity(question_index)
    when "gender"
      answers_for_gender(question_index)
    end
  end

  def answers_for_caste(question_index)
    return %w[a b c d] unless question_index == "d"
  end

  def answers_for_ethnicity(question_index)
    return %w[a b c d] if question_index == "e"
    %w[a b c d e f]
  end

  def answers_for_gender(question_index)
    return %w[a b c d e f] if question_index == "d"
    %w[a b c d] if question_index == "a"
  end
end
