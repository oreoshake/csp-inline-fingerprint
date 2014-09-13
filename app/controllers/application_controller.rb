class ApplicationController < ActionController::Base
  force_ssl unless Rails.env.development?
end
