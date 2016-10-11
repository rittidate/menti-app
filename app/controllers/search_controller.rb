class SearchController < ApplicationController
  def new
    if params[:search]
      @search = User.search(params[:search].downcase)
    end
  end
end