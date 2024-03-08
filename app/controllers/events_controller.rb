class EventsController < ApplicationController

    # show, update, destroy need event_id defined in set_event def
    before_action :set_event, only: [:show, :update, :destroy]
    before_action :authenticate_request, except: [:index]

    def index
        # events = Event.all
        # render json: events, status: :ok

        events = Event.order(created_at: :desc).page(params[:page]).per(12)
        # .page is from Kaminari
        # display 12 events per page, sort by created_at

        render json: {
            events: EventBlueprint.render_as_hash(events, view: :short), 
            total_pages: events.total_pages, 
            current_page: events.current_page
        }
        # show how many pages left from the current page
    end

    # localhost:3000/events/:id -> need to get event.id
    def show
        # render json: @event, status: :ok
        render json: EventBlueprint.render_as_hash(@event, view: :long), status: :ok   
        #display event details page
    end

    def create
         event = @current_user.created_events.new(event_params)
        # event = @current_user.events.new(event_params)

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

    def event_params 
        params.permit(:title, :content, :start_date_time, :end_date_time, :guests, :cover_image, :sport_ids => [])
        # need event user_id (replace by @current_user that contain token with user id) for association test
    end
end

# use @current_user as our way to identify who that user is and if there needs to be any data that's associated with that user we can access it easily through authenticate request