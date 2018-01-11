require 'nokogiri'
require 'open-uri'

class WikiScraper
  class Article
    attr_accessor :url, :doc

    def initialize(url)
      @url = url
      @doc = Nokogiri::HTML(open(url))
    end

    def self.get_summary(url)
      self.new(url).get_summary
    end

    def get_summary
      { "title" => get_title,
        "summary" => get_summary_text,
        "image_url" => get_image_url }
    end

    def get_title
      @doc.css("h1[id='firstHeading']").text
    end

    def get_summary_text
      summary = []
      children = @doc.css("div[class='mw-parser-output']").children
      children.each { |c| break if c.name == 'div' && c.attr('id') == 'toc'; summary << c.to_html if c.name == 'p'; }
      summary = summary.join
      summary.gsub!('<a href="/', '<a href="https://en.wikipedia.org/wiki')
      summary.gsub!('<a href="#', "<a href=\"#{@url}#")
    end

    def get_image_url
      if img = @doc.xpath("//div[@class='mw-parser-output']//img").first
        img.attr('src').gsub(/^\/+/,'')
      else
        nil
      end
    end
  end
end
