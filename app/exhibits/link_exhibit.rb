class LinkExhibit < Exhibit
  RELATIONS = %w[next prev up]

  def prev_url
    @context.url_for(prev)
  end

  def next_url
    @context.url_for(self.next)
  end

  def up_url
    @context.url_for(up)
  end

  def links_hash
    {
      links: RELATIONS.map do |rel|
        { rel: rel, href: send("#{rel}_url") }
      end
    }
  end

  def serializable_hash(*args)
    super.merge(links_hash)
  end

  def to_json(options={})
    serializable_hash(options).to_json
  end

  def self.applicable_to?(object)
    object.is_a?(Post)
  end
end