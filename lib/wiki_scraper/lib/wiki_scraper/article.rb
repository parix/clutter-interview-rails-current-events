require 'nokogiri'
require 'open-uri'

class WikiScraper
  class Article
    attr_accessor :url, :doc

    def initialize(url)
      @url = URI(url)
    end

    def doc
      @doc ||= Nokogiri::HTML(open(url))
    end

    def self.get_summary(url)
      self.new(url).get_summary
    end

    def get_summary
      if @url.host.include?("wikipedia")
        { "title" => get_title,
          "summary" => get_summary_text,
          "image_url" => get_image_url }
      end
    end

    def get_title
      doc.css("h1[id='firstHeading']").text
    end

    def get_summary_text
      summary = []
      children = doc.css("div[class='mw-parser-output']").children
      children.each do |c|
        break if c.attr('id') == 'toc' || c.xpath(".//*[contains(@id, 'toc')]").count > 0
        summary << c.to_html if c.name == 'p'
      end
      summary = summary.join
      summary.gsub!('<a href="/', '<a href="https://en.wikipedia.org/wiki')
      summary.gsub!('<a href="#', "<a href=\"#{@url}#")
      summary
      #URI.join("https://en.wikipedia.org"
    end

    def get_image_url
      if img = doc.xpath("//div[@class='mw-parser-output']//img").first
        img.attr('src')
      else
        nil
      end
    end
  end
end
