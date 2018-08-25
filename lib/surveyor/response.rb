module Surveyor
  class Response
    attr_reader :answers
    def initialize(details)
      @answers = details[:answers] || []
    end
  end
end
