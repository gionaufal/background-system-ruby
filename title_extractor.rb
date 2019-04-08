require 'open-uri'
require 'nokogiri'
require './workers/magique_worker'

RUBYMAGIC = %w(
https://www.locaweb.com.br
https://dev.to 
https://appsignal.com
https://www.uol.com.br
https://pagseguro.uol.com.br
https://gionaufal.com
https://www.suse.com
)

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
