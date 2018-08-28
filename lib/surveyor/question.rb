module Surveyor
  class Question
    attr_accessor :title, :type

    def initialize(title:, type:)
      @title = title
      @type = type
    end
  end
end
