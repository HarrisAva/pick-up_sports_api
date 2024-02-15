class EventsController < ApplicationController

    # show, update, destroy need event_id defined in set_event def
    before_action :set_event, only: [:show, :update, :destroy]
    before_action :authenticate_request

    def index
        events = Event.all
        render json: events, status: :ok
    end

    def show
        render json: @event, status: :ok
    end

    def create
        event = @current_user.created_events.new(event_params)

        if event.save
            render json: event, status: :created

        else
            render json: event.errors, status: :unprocessable_entity
        end
    end

    def update
        if @event.update(event_params)
            render json: @event, status: :ok
        else
            render json: @event.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @event.destroy
            render json: nil, status: :ok
        else
            render json: @event.error, status: :unprocessable_entity
        end
    end

    private

    def set_event
        @event = Event.find(params[:id])
    end

    def event_params # need event user_id (replace by @current_user that contain token with user id) for association test
        params.permit(:title, :content, :start_date_time, :end_date_time, :guests, :sport_ids => [])

    end
end

# use @current_user as our way to identify who that user is and if there needs to be any data that's associated with that user we can access it easily through authenticate request