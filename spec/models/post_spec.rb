require 'date'

require_relative '../spec_helper_lite'
require 'active_model'
require_relative '../../app/models/post'

describe Post do
  before do
    @it = Post.new
  end

  it 'starts with blank attributes' do
    expect(@it.title).to be_nil
    expect(@it.title).to be_nil
    expect(@it.body).to be_nil
  end

  it 'supports reading and writing a title' do
    @it.title = 'foo'
    expect(@it.title).to eq('foo')
  end

  it 'supports reading and writing a post body' do
    @it.body = 'foo'
    expect(@it.body).to eq('foo')
  end

  it 'supports reading and writing a blog reference' do
    blog = Object.new
    @it.blog = blog
    expect(@it.blog).to eq(blog)
  end

  it 'supports setting attributes in the initializer' do
    it = Post.new(title: 'mytitle', body: 'mybody')
    expect(it.title).to eq('mytitle')
    expect(it.body).to eq('mybody')
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
      expect(@blog).to receive(:add_entry) { [@it] }
      @it.publish
    end

    describe 'given an invalid post' do
      before do @it.title = nil end

      it 'wont add the post to the blog' do
        expect(@blog).to receive(:add_entry).exactly(0).times
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
        expect(@it.pubdate.class).to eq(DateTime)
      end

      it 'is the current time' do
        expect(@it.pubdate).to eq(@now)
      end
    end
  end
end