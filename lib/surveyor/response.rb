module Surveyor
  class Response
    attr_accessor :answers
    def initialize(answers: [], **_additional_arguments)
      @answers = answers
    end
  end
end
