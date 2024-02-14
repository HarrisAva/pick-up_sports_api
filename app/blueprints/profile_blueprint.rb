# frozen_string_literal: true

class ProfileBlueprint < Blueprinter::Base
    identifier :id
    fields :bio

    view :nomal do
        association :user, blueprint: UserBlueprint, view: :profile
    end

end
