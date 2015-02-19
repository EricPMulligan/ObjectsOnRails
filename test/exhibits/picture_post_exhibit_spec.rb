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
    @context = mock
    @it = PicturePostExhibit.new(@post, @context)
  end

  it 'delegates method calls to the post' do
    @it.title.must_equal 'TITLE'
    @it.body.must_equal 'BODY'
    @it.pubdate.must_equal 'PUBDATE'
  end

  it 'renders itself with the appropriate partial' do
    @context.stubs(:render).with( partial: '/posts/picture_body', locals: { post: @it }).returns('THE_HTML')
    @it.render_body.must_equal 'THE_HTML'
  end
end