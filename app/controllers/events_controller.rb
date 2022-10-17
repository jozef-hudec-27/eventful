class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy register_toggle]

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

  def new
    @event = Event.new
  end

  def create
    event_hash = params.dig(:event)
    @event = Event.new(name: event_hash.dig(:name), location: event_hash.dig(:location), ticket_price: event_hash.dig(:ticket_price),
                       date: event_hash.dig(:date), description: event_hash.dig(:description), organizer: current_user)

    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find_by(id: params[:id])

    if @event.nil?
      flash[:alert] = 'Event not found.'
      return redirect_to root_path
    end

    if current_user != @event.organizer
      flash[:alert] = 'You do not have permissions to edit this event.'
      redirect_to root_path
    end
  end

  def update
    @event = Event.find_by(id: params[:id])
    event_hash = params.dig(:event)

    if @event.nil?
      flash[:alert] = 'Event not found.'
      return redirect_to root_path
    end

    if current_user != @event.organizer
      flash[:alert] = 'You do not have permissions to edit this event.'
      return redirect_to root_path
    end

    if @event.update(name: event_hash.dig(:name), location: event_hash.dig(:location), ticket_price: event_hash.dig(:ticket_price),
                     date: event_hash.dig(:date), description: event_hash.dig(:description))
      redirect_to event_path(@event)
    else
      render :edit, status: :unprocessable_entity
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

  def register_toggle
    event = Event.find_by(id: params.dig(:id))

    if event.nil?
      flash[:alert] = 'Event not found.'
      return redirect_to root_path
    elsif event.organizer == current_user
      flash[:alert] = "You can't register for your own event."
      return redirect_to event_path(event)
    end

    if event.attendees.exists?(current_user.id)
      event.attendees.delete(current_user)
      flash[:notice] = 'Unregistered from an event.'
    else
      event.attendees << current_user
      flash[:notice] = 'Successfully registered for an event.'
    end

    redirect_to event_path(event)
  end
end
