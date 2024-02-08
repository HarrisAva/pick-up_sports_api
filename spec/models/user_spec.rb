require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'Validations tests' do
    it 'is not valid without a first name' do
      user = build(:user, first_name: nil); # if first_name is nil, the user is invalid

      expect(user).not_to be_valid
    end
  end
  
    it 'is not valid without a last name' do
      user = build(:user, last_name: nil)

      expect(user).not_to be_valid
    end
  
    it 'is not valid without an email' do
      user = build(:user, email: nil)

      expect(user).not_to be_valid
    end

  context 'Uniqueness tests' do
      it 'is not valid without a unique username' do
        user1 = create(:user)
        user2 = build(:user, username: user1.username)

        expect(user2).not_to be_valid
        expect(user2.errors[:username]).to include("has already been taken")
      end

      it 'is not valid without a unique email' do
        user1 = create(:user)
        user2 = build(:user, email: user1.email)

        expect(user2).not_to be_valid
        expect(user2.errors[:email]).to include("has already been taken")
      end
  end

  context 'destroy user and everything dependent on it' do
    let (:user) {create(:user)} # every specific test case has access to this variable
    let (:user_id) {user.id} # extract user_id to use it to destroy dependents
    
    before do # for every test case, we will destroy the specific user
      user.destroy
    end

    # delete user profile
    it 'delete user profile' do
      profile = Profile.find_by(user_id: user_id)  # if there is any profile associated to the user

      expect(profile).to be_nil
    end

    # delete user location
    it 'delete user location' do
      location = Location.find_by(locationable_id: user_id)  
      
      expect(location).to be_nil
    end

    # delete user posts
    it 'delete user posts' do
      posts = Post.where(user_id: user_id)  
      
      expect(posts).to be_empty  # array of posts to be empty
    end

    # delete user comments
    it 'delete user comments' do
      comments = Comment.where(user_id: user_id)  
      
      expect(comments).to be_empty # array of comments to be empty
    end
  end
end
