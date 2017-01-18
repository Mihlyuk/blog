require 'pry'
require 'json'
require_relative '../lib/abc.rb'

poems_file = open('db/poems.json')
poems = JSON.parse(poems_file.read)

Poem.destroy_all
Line.destroy_all
Gramm.destroy_all

poems.each do |poem|
  title = poem['title']
  lines = poem['text']

  poem = Poem.find_or_create_by(title: title)

  lines.each do |text_line|
    line = Line.create(text: text_line, poem: poem)
    gramms = text_line.scan(/[а-яА-яa-zA-Z]+/)

    gramms.each do |gramm_string|
      gramm_code = Abc.code(gramm_string)

      gramm = Gramm.find_or_create_by(id: gramm_code)
      gramm.lines << line

    end
  end

  p title
end

p 'Seeds ended.'