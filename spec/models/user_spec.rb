require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation examples here
    it "is valid" do
      user = User.new(
        name: 'Lyudmila',
        email: 'test@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      )
      expect(user).to be_valid
    end

    it 'no name provided' do
      user = User.new(name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")

      user.name = "Lyudmila"
      user.valid?
      expect(user.errors[:name]).not_to include("can't be blank")

    end

    it 'email is missing' do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")

      user.email = "test@gmail.com"
      user.valid?
      expect(user.errors[:email]).not_to include("can't be blank")
    end

    it 'email should not repeat' do
      user = User.new
      user.name = "Lyudmila",
      user.email = "abc@gmail.com",
      user.password = "123456",
      user.password_confirmation = "123456"
      user.save

      user1 = User.new
      user1.name = "Lyudmila",
      user1.email = "abc@gmail.com",
      user1.password = "123456",
      user1.password_confirmation = "123456"
      user1.save

      expect(user1.errors[:email].first).to eq("has already been taken")
    end

    it 'password length at least 5 characters' do
      user = User.new
      user.name = "Lyudmila"
      user.email = 'abc@gmail.com'
      user.password = '12345'
      user.password_confirmation = '12345'
      expect(user).to be_valid
    end


    it 'password not match' do
      user = User.new(
        name: 'Lyudmila',
        email: 'adc@gmil.com',
        password: '123456',
        password_confirmation: '123455'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
    end


  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should pass with valid credentials' do
      user = User.new(
        name: 'Lyudmila',
        email: 'abc@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      )
      user.save

      user = User.authenticate_with_credentials('abc@gmail.com', '123456')
      expect(user).not_to be(nil)
    end

    it 'should not pass with invalid credentials' do
      user = User.new(
        name: 'Lyudmila',
        email: 'abc@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      )
      user.save

      user = User.authenticate_with_credentials('abcdefg@gmail.com', '123456')
      expect(user).to be(nil)
    end

    it 'should pass even with capsital letters in email' do
      user = User.new(
        name: 'Ronaldo',
        email: 'ron@gmail.com',
        password: 'ronaldo123',
        password_confirmation: 'ronaldo123'
      )
      user.save

      user = User.authenticate_with_credentials('RON@gmail.com', 'ronaldo123')
      expect(user).not_to be(nil)
    end


  end
end
