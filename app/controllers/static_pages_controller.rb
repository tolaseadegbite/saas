class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def home
  end

  def pricing
  end

  def dashboard
    render layout: 'static_pages'
  end
end
