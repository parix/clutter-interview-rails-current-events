require 'nokogiri'
require 'open-uri'
require 'addressable'

class WikiScraper
  class Article
    class HTTPError < StandardError; end

    attr_accessor :url, :doc

    def initialize(url)
      @url = Addressable::URI.parse(url)
    end

    def doc
      begin
        @doc ||= Nokogiri::HTML(open(url))
      rescue OpenURI::HTTPError => e
        raise WikiScraper::Article::HTTPError, "#{e.message} for #{url}"
      end
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
        Addressable::URI.join("https://en.wikipedia.org", img.attr('src')).normalize.to_s
      else
        nil
      end
    end
  end
end
