require_relative '../spec_helper_lite'
require 'active_model'
require_relative '../../app/models/post'
require_relative '../../app/helpers/exhibits_helper'
require_relative '../../app/exhibits/text_post_exhibit'
require_relative '../../app/exhibits/picture_post_exhibit'

describe ExhibitsHelper do
  before do
    @it = Object.new
    @it.extend ExhibitsHelper
    @context = double
  end

  it 'decorates picture posts with a PicturePostExhibit' do
    post = Post.new
    allow(post).to receive(:picture?).and_return(true)
    expect(@it.exhibit(post, @context)).to be_kind_of(PicturePostExhibit)
  end

  it 'decorates text posts with a TextPostExhibit' do
    post = Post.new
    allow(post).to receive(:picture?).and_return(false)
    expect(@it.exhibit(post, @context)).to be_a_kind_of(TextPostExhibit)
  end

  it "leaves objects it doesn't know about alone" do
    model = Object.new
    expect(@it.exhibit(model, @context)).to eq(model)
  end
end