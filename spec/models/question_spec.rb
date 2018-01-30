require 'rails_helper'

RSpec.describe Question, :type => :model do
	subject { described_class.new(title: "some_title", description: "some_description") }

  	describe "Validations" do
	    it "is not valid without a title" do
	      subject.title = nil
	      expect(subject).to_not be_valid
	    end

	    it "is not valid without a description" do
	      subject.description = nil
	      expect(subject).to_not be_valid
	    end
	end

	describe "Associations" do
		it { should belong_to(:user) }
		it { should have_many(:answers) }
	end
end
