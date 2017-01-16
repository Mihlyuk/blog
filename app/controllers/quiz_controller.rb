class QuizController < ApplicationController

  ADDR=URI("http://pushkin.rubyroidlabs.com/quiz")

  def answer

    logger.debug params

    question = params[:question]
    level = params[:level]

    parameters = {
        answer: answer,
        token: Rails.application.secrets[:api_key],
        task_id: params[:id]
    }

    Net::HTTP.post_form(ADDR, parameters)

    Log.new(answer: answer, question: question, level: level).save

  end

end
