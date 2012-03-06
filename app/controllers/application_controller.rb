class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :find_latest_votes, :set_locale

  add_crumb "Hem", '/'
  
  def find_latest_votes
    @latest_votes = Vote.all(:order => "created_at desc", :limit => 3)
  end
  
  def set_locale
    I18n.locale = "sv" || I18n.default_locale 
  end

end
