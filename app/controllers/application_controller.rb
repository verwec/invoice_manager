class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  Dotenv.load
  BASIC_AUTH_USER = ENV['BASIC_AUTH_USER']
  BASIC_AUTH_PASSWORD = ENV['BASIC_AUTH_PASSWORD']
  http_basic_authenticate_with name: BASIC_AUTH_USER, password: BASIC_AUTH_PASSWORD
end
