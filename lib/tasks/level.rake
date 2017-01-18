require 'pry'
require_relative '../abc.rb'
require_relative '../split_words.rb'

namespace :level do
  task one: :environment do
    tasks = Log.where(level: 1)

    tasks.each do |task|
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
  end

  task two: :environment do
    tasks = Log.where(level: 2)
    tasks.each do |task|
      start = Time.now
      gramm_ids = Abc.code(split(task.question))
      question_string = task.question.scan(/[а-яА-яa-zA-Z]+|%WORD%/)
      word_index = question_string.index('%WORD%')
      answers = []

      gramm_ids.each do |id|
        if Gramm.exists?(id)
          Gramm.find(id).lines.pluck(:id, :text).each do |line_id, line_text|
            line = line_text.scan(/[а-яА-яa-zA-Z]+/)
            question = question_string
            question[word_index] = line[word_index]

            ##Или мб тут буду сразу отправлять
            answers << line[word_index] if question.join == line.join
          end
        end
      end

      answers = answers.uniq.compact
      task.answer = answers.empty? ? nil : answers[rand(answers.size)]
      task.save

      finish = Time.now
      Rails.logger.info "LEVEL 2 speed: #{finish - start}"
    end
  end

  task three: :environment do
    tasks = Log.where(level: 3)
    tasks.each do |task|
      start = Time.now
      questions = task.question.split(/\n/)
      full_answers = []

      first_answers = get_lines(questions[0])
      second_answers = get_lines(questions[1])

      first_answers.each do |f_answer|
        second_answers.each do |s_answer|
          full_answers << "#{f_answer.last},#{s_answer.last}"
        end
      end


      task.answer = full_answers.empty? ? nil : full_answers[rand(full_answers.size)]
      task.save

      finish = Time.now
      Rails.logger.info "LEVEL 3 speed: #{finish - start}"
    end
  end

  task four: :environment do
    tasks = Log.where(level: 4)
    tasks.each do |task|
      start = Time.now
      questions = task.question.split(/\n/)
      full_answers = []

      next if !questions[0] || !questions[1] || !questions[2]

      first_answers = get_lines(questions[0])
      second_answers = get_lines(questions[1])
      third_answers = get_lines(questions[2])

      first_answers.each do |f_answer|
        second_answers.each do |s_answer|
          third_answers.each do |t_answer|
            full_answers << "#{f_answer.last},#{s_answer.last},#{t_answer.last}"
          end
        end
      end

      task.answer = full_answers.empty? ? nil : full_answers[rand(full_answers.size)]
      task.save

      finish = Time.now
      Rails.logger.info "LEVEL 4 speed: #{finish - start}"
    end
  end

  def get_lines(question)
    gramm_ids = Abc.code(split(question))
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
