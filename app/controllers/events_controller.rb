class EventsController < ApplicationController

  respond_to :html, :xml, :json

  before_filter :provide_account, :except => 'create'
  before_filter :authenticate_account_by_api_token, :only => 'create'
  
  def index
    @query = params[:query] || {}
    @query[:account_id] = @account.id
    @page = params[:page] || 1
    @events = WillPaginate::Collection.create(@page, 200, Event.count(@query)) do |pager|
      events = Event.find_matching_cons(@query, :descending => true, :skip => pager.offset, :limit => pager.per_page).to_a
      pager.replace(events)
    end
  end

  def show
    @event = Event.find(params[:id])
    @history = @event.find_all_like_this(:descending => true).to_a
  end
  
  def create
    @event = Event.new(params[:event])
    @event.account = @account

    if @event.save
      respond_with(@event, :location => [@account, @event])
    else
      render :text => @event.errors, :status => :unprocessable_entity
    end
  end

  def hide_additional_data_item
    @event = Event.find(params[:id])
    @key = params[:key]
  end

  def show_additional_data_item
    @event = Event.find(params[:id])
    @key = params[:key]
    @item = @event.additional_data.detect { |item| item['key'] == @key }
  end

  private
  
  def authenticate_account_by_api_token
    @account = Account.find_by_api_token(params[:api_token])
  end
  
  def provide_account
    @account = Account.find(params[:account_id]) if params[:account_id]
  end
end
