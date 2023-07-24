class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["HAMASUKE_BASIC_AUTH_ID"], password: ENV["HAMASUKE_BASIC_AUTH_PW"]
end
