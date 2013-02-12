require 'spec_helper'

describe "micro_posts/show" do
  before(:each) do
    @micro_post = assign(:micro_post, stub_model(MicroPost,
      :user_id => "User",
      :content => "Content"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
    rendered.should match(/Content/)
  end
end
