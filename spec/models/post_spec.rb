require 'date'

require_relative '../spec_helper_lite'
require 'active_model'
require_relative '../../app/models/post'

describe Post do
  include SpecHelpers

  before do
    setup_nulldb
    @it = Post.new(title: 'TITLE')
    @ar = @it
  end

  after do
    teardown_nulldb
  end

  it 'supports reading and writing a blog reference' do
    blog = Object.new
    @it.blog = blog
    expect(@it.blog).to eq(blog)
  end

  it 'is not valid with a blank title' do
    [nil, '', ' '].each do |bad_title|
      @it.title = bad_title
      expect(@it).to_not be_valid
    end
  end

  it 'is valid with a non-blank title' do
    @it.title = 'x'
    expect(@it).to be_valid
  end

  describe '#publish' do
    before do
      @blog = double
      @it.blog = @blog
      @it.title = 'x'
    end

    it 'adds the post to the blog' do
      expect(@blog).to receive(:add_entry).and_return([@it])
      @it.publish
    end

    describe 'given an invalid post' do
      before do
        allow(@ar).to receive(:valid?).and_return(false)
      end

      it 'wont add the post to the blog' do
        expect(@blog).to_not receive(:add_entry)
        @it.publish
      end

      it 'returns false' do
        expect(@it.publish).to be_falsey
      end
    end
  end

  describe '#pubdate' do
    describe 'before publishing' do
      it 'is blank' do
        expect(@it.pubdate).to be_nil
      end
    end

    describe 'after publishing' do
      before do
        @now = DateTime.parse('2011-09-11T02:56')
        @clock = DateTime
        allow(@clock).to receive(:now).and_return(@now)
        @it.blog = double
        expect(@it.blog).to receive(:add_entry).once
        @it.title = 'x'
        @it.publish(@clock)
      end

      it 'is a datetime' do
        expect(@it.pubdate.class).to eq(ActiveSupport::TimeWithZone)
      end

      it 'is the current time' do
        expect(@it.pubdate).to eq(@now)
      end
    end
  end

  describe '#picutre?' do
    it 'is true when the post has a picture URL' do
      @it.image_url = 'http://example.org/foo.png'
      expect(@it.picture?).to be_truthy
    end

    it 'is false when the post has no picture URL' do
      @it.image_url = ''
      expect(@it.picture?).to be_falsey
    end
  end
end