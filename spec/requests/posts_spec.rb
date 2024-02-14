require 'rails_helper'

RSpec.describe "Posts", type: :request do # request to post to database
  describe "GET /posts" do
    # create a specific post, we have at least one post
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}

    let(:post) {create(:post)}

    # send a request for each specific test case we define here to post
    before do 
      # creating the post for every test case if they don't utilize it
      post # access to the post in order to create it
      get "/posts", headers: {Authorization: "Bearer #{token}"}
    end

    # returns a successful response
    it "returns a success response" do
      expect(response).to be_successful
    end

    # return a response with all the posts
    it "returns a response with all the posts" do
      expect(response.body).to eq(Post.all.to_json)
    end
  end

  # show 
    describe "GET /post/:id" do
    let(:post) {create(:post)}
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}

    before do
      get "/posts/#{post.id}", headers: {Authorization: "Bearer #{token}"}
      # to access this specific post 
    end

    # returns a successful response
    it "returns a success response" do
      expect(response).to be_successful
    end

    # response with the correct post respond body
    it "returns a response with the corect post" do
      expect(response.body).to eq(post.to_json)
    end
  end

  # create 
  describe "POST /posts" do
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}

    #valid params
    context "with valid params" do
  
      before do
        # make suer we have the attributes for when sending back to the request
        post_attributes =  attributes_for(:post)
        post "/posts", params: post_attributes, headers: {Authorization: "Bearer #{token}"}
      end

      # returns a successful response
      it "returns a success response" do
        expect(response).to be_successful
      end

      it "create a new post" do
        expect(Post.count).to eq(1)
      end

    end

    # invalid params
    context "with invalid params" do

      before do
        post_attributes = attributes_for(:post, content: nil)
        post "/posts", params: post_attributes, headers: {Authorization: "Bearer #{token}"}
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422) # 422 for status: :unprocessable_entity
      end
    end
  end

  # update
  describe "PUT /posts/:id" do
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}

    # valid params
    context "with valid params" do
      let(:post) {create(:post)}

      before do
        post_attributes = attributes_for(:post, content: "updated content")
        put "/posts/#{post.id}", params: post_attributes, headers: {Authorization: "Bearer #{token}"}
      end

      it "updates a post" do
        post.reload # to get the post after the update (current state)
        expect(post.content).to eq("updated content")
      end

      # returns a successful response
      it "returns a sucessful response" do
        expect(response).to be_successful
      end
    end

    # invalid params
    context "with invalid params" do
      let(:post) {create(:post)}
      
      before do
        post_attributes = {content: nil}
        put "/posts/#{post.id}", params: post_attributes, headers: {Authorization: "Bearer #{token}"}
      end
      
      it "returns a response with errors" do
        expect(response.status).to eq(422) 
      end
    end
  end

  # destroy

  describe "DELETE /post/:id" do
    let(:post){create(:post)}
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}

    before do
      delete "/posts/#{post.id}", headers: {Authorization: "Bearer #{token}"}
    end

    it "deletes a post" do
      expect(Post.count).to eq(0)
    end

    it "returns success response" do
      expect(response).to be_successful
    end
  end
end
