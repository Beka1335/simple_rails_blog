# frozen_string_literal: true

# this is SearchController
class SearchController < ApplicationController
  def index
    @query = Post.ransack(params[:q])
    @posts = @query.result(distinct: true)
  end
end
