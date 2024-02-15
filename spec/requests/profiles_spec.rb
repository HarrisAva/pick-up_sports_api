require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profile/:id" do
    let(:user) {create(:user)}
    let(:profile) {create(:profile)}
    let(:token) {auth_token_for_user(user)}

  before do
    get "/profiles/#{profile.id}", headers: {Authorization: "Bearer #{token}"}

  it "returns http success" do
    get "/profiles/show"
    expect(response).to be_successful
  end
end
end
end
