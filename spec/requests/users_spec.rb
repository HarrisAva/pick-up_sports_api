require 'rails_helper'

RSpec.describe "Users", type: :request do # request to user to database
  
  describe "GET /users" do
    # create a specific user, we have at least one user
    let(:user) {create(:user)}
    # create a variable that is used as the token
    let(:token) {auth_token_for_user(user)}

    # send a request for each specific test case we define here to user
    before do 
      # creating the user for every test case if they don't utilize it
      user # access to the user in order to create it
      get "/users", headers: {Authorization: "Bearer #{token}"}
    end

    # returns a successful response
    it "returns a success response" do
      expect(response).to be_successful
    end

    # return a response with all the users
    it "returns a response with all the users" do
      expect(response.body).to eq(User.all.to_json)
    end
  end

  # show 
    describe "GET /user/:id" do
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}

    before do
      get "/users/#{user.id}", headers: {Authorization: "Bearer #{token}"}
      # to access this specific user and attach user.id from above
    end

    # returns a successful response
    it "returns a success response" do
      expect(response).to be_successful
    end

    # response with the correct user respond body
    it "returns a response with the corect user" do
      expect(response.body).to eq(user.to_json)
    end
  end

  # create 
  describe "POST /users" do
    #valid params
    context "with valid params" do
      
      before do
        # make suer we have the attributes for when sending back to the request
        # we don't need authorization to create a user (register)
        user_attributes = attributes_for(:user)
        post "/users", params: user_attributes
      end

      # returns a successful response
      it "returns a success response" do
        expect(response).to be_successful
      end

      it "create a new user" do
        expect(User.count).to eq(1)
      end

    end

    # invalid params
    context "with invalid params" do

      before do
        user_attributes = attributes_for(:user, first_name: nil)
        post "/users", params: user_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422) # 422 for status: :unprocessable_entity
      end
    end
  end

  # update
  describe "PUT /users/:id" do

    # valid params
    context "with valid params" do
      let(:user) {create(:user)}
      let(:token) {auth_token_for_user(user)}


      before do
        user_attributes = { first_name: "John"}
        put "/users/#{user.id}", params: user_attributes, headers: {Authorization: "Bearer #{token}"}
      end

      it "updates a user" do
        user.reload # to get the user after the update (current state)
        expect(user.first_name).to eq("John")
      end

      # returns a successful response
      it "returns a sucessful response" do
        expect(response).to be_successful
      end
    end

    # invalid params
    context "with invalid params" do
      let(:user) {create(:user)}
      let(:token) {auth_token_for_user(user)}

      before do
        user_attributes = {first_name: nil}
        put "/users/#{user.id}", params: user_attributes, headers: {Authorization: "Bearer #{token}"}
      end
      
      it "returns a response with errors" do
        expect(response.status).to eq(422) 
      end
    end
  end

  # destroy

  describe "DELETE /user/:id" do
    let(:user){create(:user)}
    let(:token) {auth_token_for_user(user)}

    before do
      delete "/users/#{user.id}", headers: {Authorization: "Bearer #{token}"}
    end

    it "deletes a user" do
      expect(User.count).to eq(0)
    end

    it "returns success response" do
      expect(response).to be_successful
    end
  end
end
