FactoryBot.define do
  factory :answer do
    question_id { 1 }
    body { "Test Answer" }
  end

  factory :invalid_answer, class: Answer do
    question_id { nil }
    body { nil }
  end
end

