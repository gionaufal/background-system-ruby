require 'open-uri'
require 'nokogiri'

class TitleExtractorService
  def call(url)
    document = Nokogiri::HTML(open(url))
    title = document.css('html > head > title').first.content
    puts title.gsub(/[[:space:]]+/, ' ').strip
  rescue
    puts "Unable to find a title for #{url}"
  end
end
