require 'nokogiri'
require 'open-uri'
require 'addressable'

class WikiScraper
  class Events
    def self.get_events(month: Time.now.strftime('%B_%Y'))
      doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Portal:Current_events/#{month}"))
      doc.xpath("//*[contains(@class, 'vevent')]").inject({}) do |r, e|
        date = e.attr('id') || e.previous.previous.attr('id')
        outer_bullets = e.css("*[class='description'] > ul > li")
        r[date] = outer_bullets.map do |l|
          url = Addressable::URI.join("https://en.wikipedia.org", l.css("a").first.attributes["href"].value).normalize.to_s
          WikiScraper::Article.get_summary(url) rescue nil
        end.compact
        r
      end
    end
  end
end
