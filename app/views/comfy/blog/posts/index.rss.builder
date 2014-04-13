xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title @blog.label
    xml.description @blog.description
    xml.link comfy_blog_posts_url(@cms_site.path, @blog.path)
    
    @posts.each do |post|
      url = comfy_blog_post_url(@cms_site.path, @blog.path, post.slug)
      
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link url
        xml.guid url
      end
    end
  end
end