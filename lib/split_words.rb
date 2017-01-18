def split(text)
  big_word_exp = /[а-яА-яa-zA-Z]{4,}/
  mid_word_exp = /[а-яА-яa-zA-Z]{3,}/
  sm_word_exp = /[а-яА-яa-zA-Z]+/


  words = text.scan(big_word_exp)
  words = text.scan(mid_word_exp) if words.length < 2
  words = text.scan(sm_word_exp) if words.length < 2

  words
end
