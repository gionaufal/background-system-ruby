require 'open-uri'
require 'nokogiri'
require './workers/magique_worker'

class TitleExtractorWorker
  include Magique::Worker

  def perform(url)
    document = Nokogiri::HTML(open(url))
    title = document.css('html > head > title').first.content
    puts title.gsub(/[[:space:]]+/, ' ').strip
  rescue
    puts "Unable to find a title for #{url}"
  end
end
