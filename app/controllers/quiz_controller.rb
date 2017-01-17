class QuizController < ApplicationController

  ADDR=URI("http://pushkin.rubyroidlabs.com/quiz")

  def new
    Log.create(question_params)

    parameters = {
        answer: 'мой ответ',
        token: Rails.application.secrets[:api_key],
        task_id: params[:id]
    }

    Net::HTTP.post_form(ADDR, parameters)
  end

  private

  def question_params
    params.permit(:question, :id, :level)
  end

end
