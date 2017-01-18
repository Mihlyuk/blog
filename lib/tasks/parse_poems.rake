task :parse_poems do
  require 'pry'
  require 'open-uri'
  require 'nokogiri'
  require 'json'

  DOMAIN = 'http://rvb.ru'
  PUSHKIN = "#{DOMAIN}/pushkin"

  doc = Nokogiri::HTML(open("#{PUSHKIN}/toc.htm").read)
  doc.encoding = 'utf-8'

  result = []

  chapters = doc.css('.toc-content a').slice(0, 4)

  chapters.each do |chapter|
    chapter_href = chapter['href']

    chapter_page = Nokogiri::HTML(open("#{PUSHKIN}/#{chapter_href}").read)
    chapter_page.encoding = 'utf-8'

    chapter_page.css('.table tr a').each do |poem|
      poem_href = poem['href']

      if poem.css('.indent').empty? && Net::HTTP.get_response(URI.parse("#{PUSHKIN}/#{poem_href}")).code.to_i != 404
        poem_page = Nokogiri::HTML(open("#{PUSHKIN}/#{poem_href}").read)
        poem_page.encoding = 'utf-8'

        if poem_page.css('h1').text == '* * *'
          title = poem_page.css('#L1').text
        else
          title = poem_page.css('h1').text
        end

        poem = {
            title: title,
            text: poem_page.css('span').map { |a| a.text }
        }

        p title
        result << poem
      end
    end

  end

  File.open('lib/assets/poems2.json', 'w') do |f|
    f.write(result.to_json)
  end
end
