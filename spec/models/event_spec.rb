require 'rails_helper'

RSpec.describe Event, type: :model do

  context "validations" do

    it 'is not valid without a user' do
      event = build(:event, user:nil)
      expect(event).not_to be_valid
    end

    it 'is not valid without a title' do
      event = build(:event, title:nil)
      expect(event).not_to be_valid
    end

    it 'is not valid with start_date_time before current time' do
      event = build(:event, start_date_time: DateTime.now - 1) # start yesterday
      expect(event).not_to be_valid
    end

    it 'is not valid with start_date_time after end_date_time' do
      event = build(:event, start_date_time: DateTime.now + 1, end_date_time: DateTime.now)
      expect(event).not_to be_valid
    end
  end

  context "associations" do
    it 'belongs to a user' do
      event = build(:event)
      expect(event.user).to be_present
    end

    it 'has many comment' do  #polymorphic
      event = create(:event)
      create_list(:comment, 3, commentable: event) # create 3 comments, commentable to event (polymorphic)

      event.reload  #reload the current state of the event with comments associated with the event
      expect(event.comments.count).to eq(3)
    end

    it 'has many sports' do
      event = create(:event)
      create_list(:sport, 3, events: [event]) 
      # many to many relationship between event and sport
      # create an event, create a list 3 sports to associate each sport to the event (array of event [])
      # factory bot will do it

      event.reload
      expect(event.sports.count).to eq(3)
    end
  end

  context "destroy related associations" do
    it 'destroy event participants' do
      event = create(:event)
      event_id = event_id
      event.destroy
      event_participants = EventParticipant.where(event_id: event.id)
      expect(event_participants).to be_empty
    end
  end
end
