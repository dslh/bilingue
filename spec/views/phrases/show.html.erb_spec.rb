require 'spec_helper'

describe "phrases/show" do
  before(:each) do
    @phrase = assign(:phrase, stub_model(Phrase,
      :phrase => "MyText",
      :language => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
