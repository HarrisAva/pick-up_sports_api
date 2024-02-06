class User < ApplicationRecord

    validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 30}
    validate :validate_username
    validates :email, presence: true, uniqueness: true, length: {minimum: 5, maximum: 255}, format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :first_name, presence: true
    validates :last_name, presence: true

    # ** needed to allow an access user's posts **
    has_many :posts, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_one :location, as: :locationable, dependent: :destroy

    # events that the user has created
    has_many :created_events, class_name: 'Event', foreign_key: 'user_id'

    # events the user is participating in
    has_many :event_participants
    has_many :events, through: :event_participants
 
    # dependent: destroy - when a user is deleted, profile/comments associated with the user will be deleted.

    private
    def validate_username
        unless username =~ /\A[a-zA-Z0-9_]+\Z/
            # from the begining (A) through the end (Z) of username
            # anything outside [] is not valid username
            # + means there can be more than 1 of those inside the []
            
            errors.add(:username, "can only contain letters, numbers, and underscore, and must include at least one letter or number")
        end
    end
end
