require 'spec_helper'

describe "quizzes/show" do
  before(:each) do
    @quiz = assign(:quiz, stub_model(Quiz))
  end

  it "renders attributes in <p>" do
    render
  end
end
