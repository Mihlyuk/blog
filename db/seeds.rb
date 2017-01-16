require 'pry'
require 'json'
require_relative '../lib/alphabet.rb'

poems_file = open('db/poems.json')
poems = JSON.parse(poems_file.read)

Poem.destroy_all
Line.destroy_all
Gramm.destroy_all

poems.each do |poem|
  title = poem['title']
  lines = poem['text']

  poem = Poem.find_by(title: title) ? Poem.find_by(title: title) : Poem.create(title: title)

  lines.each do |text_line|
    line = Line.create(text: text_line, poem: poem)
    gramms = text_line.scan(/[а-яА-яa-zA-Z]+/).map

    gramms.each do |gramm_string|
      gramm_code = Alphabet.to_code(gramm_string, 4)

      if Gramm.exists?(id: gramm_code)
        gramm = Gramm.find(gramm_code)
      else
        gramm = Gramm.create(id: gramm_code)
      end

      gramm.lines << line

    end
  end

  p title
end

p 'Seeds ended.'