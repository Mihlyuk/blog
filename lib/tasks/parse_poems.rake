task :parse_poems do
  require 'pry'
  require 'open-uri'
  require 'nokogiri'
  require 'json'

  html = open('http://rupoem.ru/pushkin/all.aspx')
  doc = Nokogiri::HTML(html.read)
  doc.encoding = 'utf-8'

  result = []

  doc.css('.allpoems .content > div').each do |poem|
    title = poem.css('.poemtitle').text
    text = poem.css('.poem-text').text.scan(/^.+/)
    result << {
        title: title,
        text: text
    }

  end

  File.open('lib/assets/poems.json', 'w') do |f|
    f.write(result.to_json)
  end
end
