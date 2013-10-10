xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title 'ComfyBlog'
    xml.description 'ComfyBlog description'
    xml.link request.url
    
    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link blog_post_url(post)
        xml.guid blog_post_url(post)
      end
    end
  end
end