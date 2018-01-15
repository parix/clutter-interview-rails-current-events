require 'nokogiri'
require 'open-uri'

class WikiScraper
  class Events
    def self.get_events(month: Time.now.strftime('%B_%Y'))
      doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Portal:Current_events/#{month}"))
      doc.xpath("//*[contains(@class, 'vevent')]").inject({}) do |r, e|
        date = e.previous.previous.attr('id')
        outer_bullets = e.css("*[class='description'] > ul > li")
        p date
        r[date] = outer_bullets.map do |l|
          p "\t - #{l.text}"
          url = URI.join("https://en.wikipedia.org", l.css("a").first.attributes["href"].value).to_s
          p "\t\t URL: #{url}"
          WikiScraper::Article.get_summary(url)
        end.compact
        r
      end
    end
  end
end
