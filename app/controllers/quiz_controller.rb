require 'pry'

class QuizController < ApplicationController
  skip_before_action :verify_authenticity_token

  def solver
    question = params[:question]
    task_id = params[:id]
    level = params[:level]

    answer = answer(level, question)

    Net::HTTP.post_form(URI('http://pushkin.rubyroidlabs.com/quiz'), {
        answer: answer,
        token: '1ab57a02a9e7850f586640a2982d28c9',
        task_id: params[:id]
    })

    render plain: params[:quiz].inspect

    save_log(question, answer, level, task_id)
  end
end
