class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["FUKUSUKE_BASIC_AUTH_ID"], password: ENV["FUKUSUKE_BASIC_AUTH_PW"]
end
