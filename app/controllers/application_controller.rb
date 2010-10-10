class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :find_latest_votes
  
  def find_latest_votes
    @latest_votes = Vote.all(:order => "created_at desc", :limit => 3)
  end

end
