class Abc
  CODES = %w{ а б в г д е ё ж з и й к л м н о п р с т у ф х ц ч ш щ ъ ы ь э ю я
            a b c d e f g h i j k l m n o p q r s t u v w x y z }
  COLLISION = 4

  def self.code(text)
    if text.kind_of?(Array)
      text.map { |word| Abc::word_code(word) }
    else
      Abc::word_code(text)
    end
  end

  private

  def self.word_code(word)
    word.mb_chars.downcase.to_s.slice(0, COLLISION).split('').map do |letter|
      if CODES.index(letter).nil?
        binding.pry
      end

      "0#{CODES.index(letter) + 1}".slice(-2, 2)
    end.join.to_i
  end

end
