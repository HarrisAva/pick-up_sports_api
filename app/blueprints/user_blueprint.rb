# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base

    identifier :id

    view :normal do
        fields :username
    end

    view :extend do
        fields :username, :email, :first_name, :last_name, :password_digest
    end

    view :profile do  # see 'profiles' controller
        association :location, blueprint: LocationBlueprint
        association :posts, blueprint: PostBlueprint, view: :profile do |user, options| user.posts.order(create_at: :desc).limit(5)
        end

        association :events, blueprint: EventBlueprint, view: :profile do |user, options| user.events.order(start_date_time: :desc).limit(5)
        end
    end

end
