xml.instruct! :xml, :version => "1.0" 
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "#{@user.name}'s Feed"
    
    @feed_rss.each do |feed|
      xml.item do
        xml.ID feed.id
        xml.user feed.user.name
        xml.description feed.content
        xml.pubDate feed.created_at
        xml.link user_path(feed.user)
      end
    end
  end
end