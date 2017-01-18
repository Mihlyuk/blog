module QuizHelper

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

  def save_log
        
  end
  
  private
  
  def one(question)
    start = Time.now
    question_string = task.question.scan(/[а-яА-яa-zA-Z]+/).join(' ').mb_chars.downcase.to_s
    gramm_ids = Abc.code(split(task.question))
    answers = []

    gramm_ids.each do |id|
      if Gramm.exists?(id)
        gramm = Gramm.find(id)

        gramm.lines.pluck(:id, :text).each do |line_id, line_text|
          text = line_text.mb_chars.downcase.to_s

          if text.scan(/[а-яА-яa-zA-Z]+/).join(' ') == question_string
            answers << line_id
          end
        end
      end
    end

    answers = answers.uniq.compact

    task.answer = answers.empty? ? nil : Line.find(answers[rand(answers.size)]).poem.title
    task.save

    finish = Time.now
    Rails.logger.info "LEVEL 1 speed: #{finish - start}"
  end

  def two(question)

  end

  def three(question)

  end

  def four(question)

  end
  
end
