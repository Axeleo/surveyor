require 'spec_helper'

RSpec.describe '01: Questions and Answers' do
  class Response
    def self.find_response(responses, user)
      responses.find { |res| res[:user] == user }
    end

    def self.find_answer_set(responses, question)
      responses.map { |response| response.dig(:answers, question) }.compact
    end

    def self.answered?(responses, user, question)
      response = find_response(responses, user)
      if response
        !response[:answers][question].nil? 
      else
        puts "user #{user} not found"
      end
    end

    def self.answer_for_question_by_user(responses, question, user)
      response = find_response(responses, user)
      # I feel like this conditional should be refactored into a seperate method as i'm using small variations of it multiple times. Unsure of how to achieve this, error handling?
      if response
        response[:answers][question]
      else
        puts "user #{user} not found"
      end
    end

    # I feel like this method should be inside a mixin/helper
    def self.get_percentage_round_2(part, whole)
      percentage =  part.to_f / whole * 100
      percentage.round(2)
    end

    def self.question_average(responses, question)
      answer_set = find_answer_set(responses, question)
      average = answer_set.sum / answer_set.count.to_f
      average.round(2)
    end

    def self.question_participation_percentage(responses, question)
      answer_set = find_answer_set(responses, question)
      get_percentage_round_2(answer_set.count, responses.count)
    end

    def self.overall_participation_percentage(responses)
      total_num_participants = responses.count { |res| res[:answers].any? }
      get_percentage_round_2(total_num_participants, responses.count)
    end
  end

  let(:responses) do
    [
      { user: "alice@example.com", answers: { q1: 1, q2: 2, q3: 4 } },
      { user: "bob@example.com", answers: { q1: 1, q2: 4, q3: 5 } },
      { user: "frank@example.com", answers: { q3: 5 } },
      { user: "claire@example.com", answers: {} },
      { user: "ella@example.com", answers: {} },
      { user: "sharon@example.com", answers: {} },
      { user: "ryan@example.com", answers: {} },
    ]
  end

  context "answered?" do
    it "determines that question 1 has been answered by alice" do
      expect(Response).to be_answered(responses, "alice@example.com", :q1)
    end

    it "determines that question has not been answered by frank" do
      expect(Response).not_to be_answered(responses, "frank@example.com", :q2)
    end

    it "does not error out if a respondent is not in the survey" do
      expect(Response).not_to be_answered(responses, "augustus@example.com", :q2)
    end
  end

  context "answer_for_question_by_user" do
    it "gets the answer for question 1 by bob" do
      expect(Response.answer_for_question_by_user(responses, :q1, "bob@example.com")).to eq(1)
    end

    it "gets no answer for question 4 from frank" do
      expect(Response.answer_for_question_by_user(responses, :q4, "frank@example.com")).to be_nil
    end

    it "returns nil for people who have not responded" do
      expect(Response.answer_for_question_by_user(responses, :q4, "claire@example.com"))
    end
  end

  context "question_average" do
    it "determines the average for question 1" do
      expect(Response.question_average(responses, :q1)).to eq(1)
    end

    it "determines the average for question 3" do
      expect(Response.question_average(responses, :q3)).to eq(4.67)
    end
  end

  context "question participation percentage" do
    # NOTE: This percentage is the number of people who have answered question #1.
    # If someone has answered this question, then we will say that they have "participated".
    # This number is rounded to 2 decimal places.
    it "works out participation percentage for question 1" do
      expect(Response.question_participation_percentage(responses, :q1)).to eq(28.57)
    end

    it "works out the participation percentage for question 3" do
      expect(Response.question_participation_percentage(responses, :q3)).to eq(42.86)
    end

    it "works out the participation percentage for question 4" do
      expect(Response.question_participation_percentage(responses, :q4)).to eq(0)
    end
  end

  context "overall participation percentage" do
    # NOTE: People are considered to have participated if they have answered at least 1 question.
    it "works out the overall participation percentage" do
      expect(Response.overall_participation_percentage(responses)).to eq(42.86)
    end
  end
end
