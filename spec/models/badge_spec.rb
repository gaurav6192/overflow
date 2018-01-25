require 'rails_helper'

RSpec.describe Badge, :type => :model do
	subject { described_class.new(name: "foo") }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with existing name" do
	  	should validate_uniqueness_of(:name).case_insensitive
	  end
  end
end