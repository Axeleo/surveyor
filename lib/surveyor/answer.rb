require 'pry'
module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(question: nil, value:)
      @question = question
      @value = value
    end

    def valid?
      return false if @question.nil?
      (1..5).cover?(@value) || @value.to_i.zero?
    end
  end
end
