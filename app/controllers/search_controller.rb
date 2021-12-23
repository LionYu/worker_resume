class SearchController < ApplicationController
  before_action :set_q

  def query
    # debugger
    @results = if @q.blank?
      []
    else
      @q.split.collect{|q| Worker.index[q.downcase] || [] }.inject(:&)
    end
  end

  private
    def set_q
      @q = params[:query] || ""
    end
end
