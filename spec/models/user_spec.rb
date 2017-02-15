require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new }

  describe "validations" do
    it 'requires presence of an email' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).not_to be_empty
    end

    it 'invalid email format should be rejected' do
      user.email = "fake-email"
      user.valid?
      expect(user.errors[:email]).not_to be_empty
    end

    it 'requires presence of a password' do
      user.password = nil
      user.valid?
      expect(user.errors[:password]).not_to be_empty
    end

    it 'too short password should be rejected' do
      user.password = "bla"
      user.valid?
      expect(user.errors[:password]).not_to be_empty
    end

  end

end
