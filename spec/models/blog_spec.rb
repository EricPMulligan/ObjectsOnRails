require 'spec_helper_lite'
require_relative '../../app/models/blog'
require 'ostruct'
require 'date'

describe Blog do
  before do
    @entries = []
    @it = Blog.new(->{@entries})
  end

  it 'has no entries' do
    expect(@it.entries).to be_empty
  end

  describe '#new_post' do
    before do
      @new_post = OpenStruct.new
      @it.post_source = ->{ @new_post }
    end

    it 'returns a new post' do
      expect(@it.new_post).to eq(@new_post)
    end

    it "sets the post's blog reference to itself" do
      expect(@it.new_post.blog).to eq(@it)
    end

    it 'accepts an attribute hash on behalf of the post maker' do
      post_source = spy
      # post_source.expect(:call, @new_post, [{ x: 42, y: 'z' }])
      @it.post_source = post_source
      @it.new_post(x: 42, y: 'z')
      expect(post_source).to have_received(:call).with({ x: 42, y: 'z' })
    end
  end

  describe '#add_entry' do
    it 'adds the entry to the blog' do
      entry = double
      expect(entry).to receive(:save)
      @it.add_entry(entry)
    end
  end
end