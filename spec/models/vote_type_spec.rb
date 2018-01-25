require 'rails_helper'

RSpec.describe VoteType, type: :model do
  subject { described_class.new(name: "foo", score_change: 1) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a score change" do
      subject.score_change = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with existing name" do
	  	should validate_uniqueness_of(:name).case_insensitive
	  end
  end
end
