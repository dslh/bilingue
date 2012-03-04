require 'spec_helper'

describe "phrases/index" do
  before(:each) do
    assign(:phrases, [
      stub_model(Phrase,
        :phrase => "MyText",
        :language => nil
      ),
      stub_model(Phrase,
        :phrase => "MyText",
        :language => nil
      )
    ])
  end

  it "renders a list of phrases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
