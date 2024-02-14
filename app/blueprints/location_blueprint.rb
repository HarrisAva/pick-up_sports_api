# frozen_string_literal: true

class LocationBlueprint < Blueprinter::Base
    identifer :id
    fields :zip_code, :city, :state, :country, :address
end
