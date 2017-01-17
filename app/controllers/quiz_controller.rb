class QuizController < ApplicationController
  def solver
    uri = URI("http://pushkin.rubyroidlabs.com/quiz")

    parameters = {
        answer: 'test',
        token: '1ab57a02a9e7850f586640a2982d28c9',
        task_id: params['id']
    }

    Net::HTTP.post_form(uri, parameters)

    Log.create(params.permit(:question, :id, :level))
  end
end
