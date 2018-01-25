require 'rails_helper'

RSpec.describe UserStat, :type => :model do
	let(:user) { User.new(id: 1) }
  subject { described_class.new(user: user) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a questions count" do
      subject.questions_count = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an answers count" do
      subject.answers_count = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a user id" do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
  	it "belongs to user" do
  		should belong_to(:user)
  	end
  end
end