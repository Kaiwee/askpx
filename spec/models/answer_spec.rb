require 'rails_helper'

RSpec.describe Answer, :type => :model do
	subject { described_class.new(description: "some_description") }

  	describe "Validations" do
	    it "is not valid without a description" do
	      subject.description = nil
	      expect(subject).to_not be_valid
	    end
	end

	describe "Associations" do
		it { should belong_to(:user) }
		it { should belong_to(:question) }
	end

end
