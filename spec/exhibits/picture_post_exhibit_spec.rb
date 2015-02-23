require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/picture_post_exhibit'
require 'ostruct'

describe PicturePostExhibit do
  before do
    @post = OpenStruct.new(
      title: 'TITLE',
      body: 'BODY',
      pubdate: 'PUBDATE'
    )
    @context = double
    @it = PicturePostExhibit.new(@post, @context)
  end

  it 'delegates method calls to the post' do
    expect(@it.title).to eq('TITLE')
    expect(@it.body).to eq('BODY')
    expect(@it.pubdate).to eq('PUBDATE')
  end

  it 'renders itself with the appropriate partial' do
    allow(@context).to receive(:render).with( partial: '/posts/picture_body', locals: { post: @it }).and_return('THE_HTML')
    expect(@it.render_body).to eq('THE_HTML')
  end
end