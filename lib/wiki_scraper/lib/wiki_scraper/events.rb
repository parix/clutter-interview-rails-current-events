require 'nokogiri'
require 'open-uri'

class WikiScraper
  class Events
    def self.get_events(month: Time.now.strftime('%B_%Y'))
      doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Portal:Current_events/#{month}"))
      doc.css("div[class='vevent']").inject({}) do |r, e|
        outer_bullets = e.css("div[class='description'] > ul > li")
        r[e.attributes["id"].value] = outer_bullets.map do |l|
          WikiScraper::Article.get_summary("https://en.wikipedia.org#{ l.css("a").first.attributes["href"].value }")
        end
        r
      end
    end
  end
end
