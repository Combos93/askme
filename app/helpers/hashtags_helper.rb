module HashtagsHelper
  def hashtags_link(link)
   link = link.scan(/#[[:word:]_]+/)
    link.map! do |tag|
      tag.delete unless tag.include?("#")
      link_to tag, hashtag_url(tag)
    end
    link.join(", ").html_safe
  end
end
