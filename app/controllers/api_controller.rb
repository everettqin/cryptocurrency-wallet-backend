require 'api_responder'

class APIController < ApplicationController

  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_administrator!

  self.responder = APIResponder
  respond_to :json

  include ::API::ErrorHandler


  def page_params
    params[:page] || 1
  end

  def query_params
    params[:query] || nil
  end

  def filter_params
    params[:filter] || {}
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
end
