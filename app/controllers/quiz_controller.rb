class QuizController < ApplicationController
  def solver
    logger.debug 'asdasdasdasdasd'
    Log.create(question: 'asdasdsa', answer: 'asdads', level: 4, task_id: '12312')
  end
end
