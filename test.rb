require "pp"
a = UserQuiz.find(14)

p "-" * 30


a.quiz.questions.each do |q|
  p "Question: #{q.name}"
  q.answers.each do |a|
    p "Answers: #{a.value}"
  end

  p "~" * 5
end


p "-" * 30