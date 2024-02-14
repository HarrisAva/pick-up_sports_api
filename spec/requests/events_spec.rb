require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) {create(:user)}
  let(:token) {auth_token_for_user(user)}

  # get events - index
  describe "GET /events" do
   it 'returns a response with all the event' do
    create(:event)
    get '/events', headers: {Authorization: "Bearer #{token}"}
    expect(response.body).to eq(Event.all.to_json)
   end
  end

  # get event - show
  describe "GET /event" do
    let(:event) {create(:event)}

    it 'returns a response with the specified event' do
      get"/events/#{event.id}", headers: {Authorization: "Bearer #{token}"}
      expect(response.body).to eq(event.to_json)
    end
  end

  # create event - create
  describe "POST /events" do
    # event associate with user, sport, comment
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}
    let(:sport) {create(:sport)}

    before do
      event_attributes = attributes_for(:event, sport_ids: [sport.id])
      post "/events", params: event_attributes, headers: {Authorization: "Bearer #{token}"}
    end

    it 'creates a new event' do
      expect(Event.count).to eq(1)
    end

    it 'returns success response' do
      expect(response).to be_successful
    end
  end

  # update event - update
  describe "PUT /events/:id" do
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}
    let (:event) {create(:event)}

    before do
      put "/events/#{event.id}", params: {title: "New Title"}, headers: {Authorization: "Bearer #{token}"}
    end

    it 'updates an event' do
      event.reload # reload the event after updating
      expect(event.title).to eq("New Title")
    end
  end

  # delete event - destroy
  describe "DELETE /event/:id" do
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}
    let (:event) {create(:event)}

    before do
      delete "/events/#{event.id}", headers: {Authorization: "Bearer #{token}"}
    end

    it 'deletes an event' do
      expect(Event.count).to eq(0)
    end

    it "destroy event participants" do
      event_participants = EventParticipant.where(event_id: event.id)
      expect(event_participants).to be_empty
    end

  end
end
