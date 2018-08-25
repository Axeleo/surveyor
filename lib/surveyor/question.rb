module Surveyor
  class Question
    attr_reader :title, :type

    def initialize(details)
      @title = details[:title]
      @type = details[:type]
    end
  end
end
