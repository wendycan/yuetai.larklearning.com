#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "阅台"
    xml.author "wendy"
    xml.description "记录想法， 分享点滴"
    xml.link "http://yuetai.larklearning.com"
    xml.language "zh"

    for article in @articles
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author article.user.username
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "http://yuetai.larklearning.com/articles/" + article.id.to_s
        xml.guid article.id

        text = article.body
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end
