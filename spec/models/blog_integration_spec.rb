require_relative '../spec_helper_full'

describe Blog do
  include SpecHelpers

  before do
    setup_database
    @it = Blog.new
  end

  after do
    teardown_database
  end

  describe '#entries' do
    def make_entry_with_date(date)
      @it.new_post(pubdate: DateTime.parse(date), title: date)
    end

    it 'is sorted in reverse-chronological order' do
      oldest = make_entry_with_date('2011-09-09')
      newest = make_entry_with_date('2011-09-11')
      middle = make_entry_with_date('2011-09-10')

      @it.add_entry(oldest)
      @it.add_entry(newest)
      @it.add_entry(middle)
      expect(@it.entries).to match_array([newest, middle, oldest])
    end

    it 'is limited to 10 items' do
      10.times do |i|
        @it.add_entry(make_entry_with_date("2011-09-#{i + 1}"))
      end
      oldest = make_entry_with_date('2011-08-30')
      @it.add_entry(oldest)
      expect(@it.entries.size).to eq(10)
      expect(@it.entries).to_not include(oldest)
    end
  end
end