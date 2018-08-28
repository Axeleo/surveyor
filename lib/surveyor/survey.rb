require 'pry'
module Surveyor
  class Survey
    attr_reader :name, :questions, :responses

    def initialize(name:, questions: [], responses: [])
      @name = name
      @questions = questions
      @responses = responses
    end
    
    def participation_percentage(query_question)
      respondent_count = @responses.count do |res|
        res.answers.any? do |a|
          a.question == query_question
        end
      end
      (respondent_count.to_f / responses.count * 100).round(2)
    end

    def ratings(query_question)
      ratings = { 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0 }
      results = @responses
        .flat_map(&:answers)
        .select { |answer| answer.question == query_question }
        .each { |answer| ratings[answer.value] += 1 }
      ratings
    end
  end
end
