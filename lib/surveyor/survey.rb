module Surveyor
  class Survey
    attr_reader :name, :questions, :responses

    def initialize(details)
      @name = details[:name]
      @questions = details[:questions] || []
      @responses = details[:responses] || []
    end
    
    def participation_percentage(query_question)
      pariticpation_count = 0
      responses.each do |res|
        res.answers.each do |answer|
          pariticpation_count += 1 if answer.question == query_question
        end
      end
      percentage =  pariticpation_count.to_f / responses.count * 100
      percentage.round(2)
    end

    def ratings(query_question)
      ratings = {
        1 => 0,
        2 => 0,
        3 => 0,
        4 => 0,
        5 => 0
      }
      responses.each do |res|
        res.answers.each do |answer|
          ratings[answer.value] += 1 if answer.question == query_question
        end
      end
      ratings
    end
  end
end
