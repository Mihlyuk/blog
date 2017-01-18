module QuizHelper
  CODES = %w{ а б в г д е ё ж з и й к л м н о п р с т у ф х ц ч ш щ ъ ы ь э ю я
            a b c d e f g h i j k l m n o p q r s t u v w x y z }
  COLLISION = 4

  def answer(level, question)
    case level
      when 1
        one(question)
      when 2
        two(question)
      when 3
        three(question)
      when 4
        four(question)
    end
  end

  def save_log(question, answer, level, task_id)

  end

  private

  def split(text)
    big_word_exp = /[а-яА-яa-zA-Z]{4,}/
    mid_word_exp = /[а-яА-яa-zA-Z]{3,}/
    sm_word_exp = /[а-яА-яa-zA-Z]+/

    words = text.scan(big_word_exp)
    words = text.scan(mid_word_exp) if words.length < 2
    words = text.scan(sm_word_exp) if words.length < 2

    words
  end

  def code(text)
    if text.kind_of?(Array)
      text.map { |word| word_code(word) }
    else
      word_code(text)
    end
  end

  def word_code(word)
    word.mb_chars.downcase.to_s.slice(0, COLLISION).split('').map do |letter|
      if CODES.index(letter).nil?
        binding.pry
      end

      "0#{CODES.index(letter) + 1}".slice(-2, 2)
    end.join.to_i
  end


  def one(question)
    question_string = question.scan(/[а-яА-яa-zA-Z]+/).join(' ').mb_chars.downcase.to_s
    gramm_ids = code(split(question))
    gramm_ids.each do |id|
      if Gramm.exists?(id)
        gramm = Gramm.find(id)
        gramm.lines.each do |line|
          text = line.text.mb_chars.downcase.to_s

          if text.scan(/[а-яА-яa-zA-Z]+/).join(' ') == question_string
            return line
          end
        end
      end
    end
  end

  def two(question)
    gramm_ids = code(split(question))
    question_string = question.scan(/[а-яА-яa-zA-Z]+|%WORD%/)
    word_index = question_string.index('%WORD%')

    gramm_ids.each do |id|
      if Gramm.exists?(id)
        Gramm.find(id).lines.each do |line|
          text = line.text.scan(/[а-яА-яa-zA-Z]+/)
          question = question_string
          question[word_index] = text[word_index]

          return text[word_index] if question.join == text.join
        end
      end
    end
  end

  def three(question)
    questions = question.split(/\n/)

    first_answers = get_lines(questions[0])
    second_answers = get_lines(questions[1])

    first_answers.each do |f_answer|
      second_answers.each do |s_answer|
        return "#{f_answer.last},#{s_answer.last}"
      end
    end
  end

  def four(question)
    questions = question.split(/\n/)
    return nil if !questions[0] || !questions[1] || !questions[2]

    first_answers = get_lines(questions[0])
    second_answers = get_lines(questions[1])
    third_answers = get_lines(questions[2])

    first_answers.each do |f_answer|
      second_answers.each do |s_answer|
        third_answers.each do |t_answer|
          return "#{f_answer.last},#{s_answer.last},#{t_answer.last}"
        end
      end
    end
  end

  def get_lines(question)
    gramm_ids = code(split(question))
    question_string = question.scan(/[а-яА-яa-zA-Z]+|%WORD%/)
    word_index = question_string.index('%WORD%')
    answers = []

    gramm_ids.each do |id|
      if Gramm.exists?(id)
        Gramm.find(id).lines.pluck(:id, :text).each do |line_id, line_text|
          line = line_text.scan(/[а-яА-яa-zA-Z]+/)
          change_question = question_string
          change_question[word_index] = line[word_index]

          if change_question.join == line.join
            answers << [line_id, line[word_index]]
          end
        end
      end
    end

    answers.uniq.compact
  end

end
