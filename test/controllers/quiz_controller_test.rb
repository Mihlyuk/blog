require 'test_helper'

class QuizControllerTest < ActionDispatch::IntegrationTest
  log = Log.where(level: 1).take

  post "/quiz",
       params: {
           level: log.level,
           id: log.task_id,
           question: log.question
       }

  assert_response :success
  assert_select "p", "Title:\n  can create"
end
