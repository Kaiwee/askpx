require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new(password: "some_password", email: "john@doe.com") }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it { should validate_uniqueness_of(:email) }
  end

  describe "Associations" do
    it { should have_many(:questions) }
    it { should have_many(:answers) }
    it { should have_many(:authentications) }
  end

  describe "Generate token" do
    it "should generate a auth_token when user click remember_me button" do
      user = User.new(password: "some_password", email: "john@doe.com", auth_token: "")
      user.save
      expect(user.auth_token).not_to be_empty
    end
  end

  describe "Generate fb token" do
    it "should return fb token if authentication exists" do
      user = User.new(password: "some", email: "joh@doe.com")
      user.save
      authentication = Authentication.new(uid: "some_uid", provider: "facebook", token: "12345", user_id: user.id)
      authentication.save
      expect(user.fb_token).to eq("12345")
    end

    it "should not return fb token if authentication is not exist" do
      user = User.new(password: "some", email: "joh@doe.com")
      user.save
      authentication = Authentication.new(uid: "some_uid", provider: "google", token: "12345", user_id: user.id)
      authentication.save
      expect(user.fb_token).to be_nil
    end
  end

end