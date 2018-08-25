module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(details)
      @question = details[:question]
      @value = details[:value]
    end

    def valid?
      if !@question.nil?
        if @value.to_i <= 5 && @value.to_i >= 1 || @value.to_i.zero?
          true
        else
          false
        end
      else
        false
      end
    end
  end
end
