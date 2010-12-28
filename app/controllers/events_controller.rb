class EventsController < ApplicationController

  def index
    query = params[:query] || {}
    @events = WillPaginate::Collection.create(params[:page] || 1, 200, Event.search(query, :returns => :rows).size) do |pager|
      events = Event.search(query, :descending => true, :skip => pager.offset, :limit => pager.per_page).to_a
      pager.replace(events)
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      render :xml => @event, :status => :created, :location => @event
    else
      render :xml => @event.errors, :status => :unprocessable_entity
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
end
