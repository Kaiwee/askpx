require 'rails_helper'

RSpec.describe Question, type: :model do
	describe "Associations" do
	it { should belong_to(:user) }
	it { should have_many(:answers) }
	end
end
