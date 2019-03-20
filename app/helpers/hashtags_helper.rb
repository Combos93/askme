module HashtagsHelper
  def hashtags_link(link)
    link.downcase!

    link = link.scan(/#[[:word:]_]+/)
    link = link.uniq

    link.map! { |tag| link_to tag, hashtag_url(tag) }

    link.join(", ").html_safe
  end
end
