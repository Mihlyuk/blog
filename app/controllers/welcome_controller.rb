class WelcomeController < ApplicationController
  IMAGES_PATH = File.join(Rails.root, 'db')

  def index
    send_file(File.join(IMAGES_PATH, 'development.sqlite3'))
  end
end
