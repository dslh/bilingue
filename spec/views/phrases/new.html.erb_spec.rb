require 'spec_helper'

describe "phrases/new" do
  before(:each) do
    assign(:phrase, stub_model(Phrase,
      :phrase => "MyText",
      :language => nil
    ).as_new_record)
  end

  it "renders new phrase form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => phrases_path, :method => "post" do
      assert_select "textarea#phrase_phrase", :name => "phrase[phrase]"
      assert_select "input#phrase_language", :name => "phrase[language]"
    end
  end
end
