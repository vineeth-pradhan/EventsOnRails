class EventsController < ApplicationController
  before_action :set_event, only: :show

  # GET /events
  # GET /events.json
  def index
    @events = Event.valid_dates
    @events = @events.after_startdate(params[:startdate]) if params[:startdate].present?
    @events = @events.before_enddate(params[:enddate]) if params[:enddate].present?
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :starttime, :endtime, :description, :allday)
  end
end
