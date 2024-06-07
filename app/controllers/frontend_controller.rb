# app/controllers/frontend_controller.rb
class FrontendController < ApplicationController
  def index
    render file: Rails.root.join('public', 'index.html')
  end
end
