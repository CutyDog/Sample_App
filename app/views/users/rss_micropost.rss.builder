xml.instruct! :xml, :version => "1.0" 
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "#{@user.name}'s Microposts"
    
    @post_rss.each do |post|
      xml.item do
        xml.ID post.id
        xml.user post.user.name
        xml.description post.content
        xml.pubDate post.created_at
        xml.link user_path(post.user)
      end
    end
  end
end