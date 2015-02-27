require_relative '../spec_helper_full'

describe Post do
  include SpecHelpers

  before do
    setup_database
    @it = Blog.new
  end

  after do
    teardown_database
  end

  def make_post(*args)
    post = @it.new_post(args[0])
    post.save
    post
  end

  it "defaults body to 'Nothing to see here'" do
    post = make_post(body: '')
    expect(post.body).to eq('Nothing to see here')
  end
end