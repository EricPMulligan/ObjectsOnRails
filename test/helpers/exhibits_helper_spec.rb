require_relative '../spec_helper_lite'
require_relative '../../app/helpers/exhibits_helper'

class PicturePostExhibit; def initialize(*args); end; end
class TextPostExhibit; def initialize(*args); end; end

describe ExhibitsHelper do
  before do
    @it = Object.new
    @it.extend ExhibitsHelper
    @context = mock
  end

  it 'decorates picture posts with a PicturePostExhibit' do
    post = mock('Post')
    post.stubs(:picture?).returns(true)
    @it.exhibit(post, @context).must_be_kind_of(PicturePostExhibit)
  end

  it 'decorates text posts with a TextPostExhibit' do
    post = mock('Post')
    post.stubs(:picture?).returns(false)
    @it.exhibit(post, @context).must_be_kind_of(TextPostExhibit)
  end

  it "leaves objects it doesn't know about alone" do
    model = Object.new
    @it.exhibit(model, @context).must_be_same_as(model)
  end
end