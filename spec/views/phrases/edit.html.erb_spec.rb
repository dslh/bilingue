require 'spec_helper'

describe "phrases/edit" do
  before(:each) do
    @phrase = assign(:phrase, stub_model(Phrase,
      :phrase => "MyText",
      :language => nil
    ))
  end

  it "renders the edit phrase form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => phrases_path(@phrase), :method => "post" do
      assert_select "textarea#phrase_phrase", :name => "phrase[phrase]"
      assert_select "input#phrase_language", :name => "phrase[language]"
    end
  end
end
