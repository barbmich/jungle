require 'rails_helper'

RSpec.describe User, type: :model do
  describe "check positive output when all fields are correctly filled" do

    it "should create a valid user" do
      @user = User.new(name: "Bob", email: "test@test.com", password: "password", password_confirmation: "password")
      @user.save
      expect(@user.name).to eq("Bob")
      expect(@user.email).to eq("test@test.com")
      expect(@user.password).to eq("password")
      expect(@user.password_confirmation).to eq("password")
    end
  end

  describe "check validation errors when fields are empty" do

    it "should return the following issues" do
      @user = User.new(name: nil, email: nil, password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
      expect(@user.errors.full_messages).to include("Email can't be blank")
      expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
  end

  describe "check validation error for email issues" do
    
    it "should return email is already in use" do 
      @user = User.new(name: "Bob", email: "test@test.com", password: "password", password_confirmation: "password")
      @user.save
      @user2 = User.new(name: "Sam", email: "test@test.com", password: "drowssap", password_confirmation: "drowssap")
      @user2.save
      @user3 = User.new(name: "Jim", email: "TeSt@tEsT.cOm", password: "drowssap1", password_confirmation: "drowssap1")
      @user3.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")
      expect(@user3.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe "check validation errors for several password issues" do
    
    it "should return password is too short" do
      @user = User.new(name: "Bob", email: "test@test.com", password: "pass", password_confirmation: "pass")
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it "should return passwords don't match" do
      @user = User.new(name: "Bob", email: "test@test.com", password: "password", password_confirmation: "testconfirmation")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe "check password" do
    it "checking .authenticate_with_credentials" do
      new_user = User.new(name: "Bob", email: "test@test.com", password: "password", password_confirmation: "password")
      new_user.save
      user_connecting = User.authenticate_with_credentials("test@test.com", "password")
      expect(user_connecting).to eq(new_user)
    end
  end

end
