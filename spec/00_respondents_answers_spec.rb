require 'spec_helper'
require 'pry'

RSpec.describe '00: Respondent Answers' do
  class Response
    def self.count(responses)
      responses.count
    end

    def self.for(responses, user)
      responses.find { |res| res[:user] == user } 
    end

    def self.present?(responses, user)
      # converting expression to boolean
      !!self.for(responses, user)
    end

    def self.positive(responses)
      awnser_threshold = 3
      response_over_threshold = responses.select { |res| res[:answer] > awnser_threshold }
      response_over_threshold.count
    end

    def self.negative(responses)
      awnser_threshold = 3
      response_under_threshold = responses.select { |res| res[:answer] < awnser_threshold }
      response_under_threshold.count
    end

    def self.average(responses)
      total_res_score = 0
      responses.each { |res| total_res_score += res[:answer] }
      total_res_score / responses.count.to_f
    end
  end

  let(:responses) do
    [
      { user: "alice@example.com", answer: 1 },
      { user: "bob@example.com", answer: 2 },
      { user: "frank@example.com", answer: 3 },
      { user: "claire@example.com", answer: 4 },
    ]
  end

  context "count" do
    it "counts the number of responses" do
      expect(Response.count(responses)).to eq(4)
    end
  end

  context "for" do
    it "finds the response from frank@example.com" do
      response = Response.for(responses, "frank@example.com")
      expect(response[:answer]).to eq(3)
    end

    it "finds the response from bob@example.com" do
      response = Response.for(responses, "bob@example.com")
      expect(response[:answer]).to eq(2)
    end
  end

  context "present?" do
    it "frank@example.com's response is present" do
      expect(Response.present?(responses, "frank@example.com")).to be true
    end

    it "bill@example.com's response is not present" do
      expect(Response.present?(responses, "bill@example.com")).to be false
    end
  end

  context "positive" do
    it "finds the positive responses (score > 3)" do
      expect(Response.positive(responses)).to eq(1)
    end
  end

  context "negative" do
    it "finds the negative responses (score < 3)" do
      expect(Response.negative(responses)).to eq(2)
    end
  end

  context "average" do
    it "finds the average of the answers" do
      expect(Response.average(responses)).to eq(2.5)
    end
  end
end
