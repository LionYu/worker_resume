class SearchController < ApplicationController
  before_action :set_q

  def query
    # debugger
    @results = if @q.blank?
      []
    else
      # do query and renturn result
      [1,2,3,4]
    end
  end

  private
    def set_q
      @q = params[:query] || ""
    end
end
