class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(id: params[:id])

    if @event.nil?
      flash[:alert] = 'Event not found.'
      return redirect_to root_path
    end
  end

  def destroy
    event = Event.find_by(id: params[:id])

    if event.nil?
      flash[:alert] = 'Event does not exist.'
      return redirect_to root_path
    end

    if current_user == event.organizer
      event.destroy
      flash[:notice] = 'Event has been deleted.'
      redirect_to root_path
    else
      flash[:alert] = 'You do not have permissions to delete this event.'
      redirect_to root_path
    end
  end
end
