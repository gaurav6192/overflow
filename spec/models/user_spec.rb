require 'rails_helper'

RSpec.describe User, type: :model do
	subject { described_class.new(email: "foo@bar.com", full_name: "Foo Bar", user_name: "foobar", 
																password: "123456", password_confirmation: "123456") }

	describe "Validations" do
	  it "is valid with valid attributes" do
	  	expect(subject).to be_valid
	  end
	  
	  it "is not valid without a email" do
	  	subject.email = nil
	  	expect(subject).to_not be_valid
	  end

	  it "is not valid with email more than 255 characters" do
	  	subject.email = "a" * 248 << "@1mg.com"
	  	expect(subject).to_not be_valid
	  end

	  it "saves email as lower case" do
	  	email = subject.email
	  	subject.email = email.upcase
	  	subject.save
	  	expect(subject.email).to be_eql(email)
	  end

	  it "is not valid with existing email" do
	  	should validate_uniqueness_of(:email).case_insensitive
	  end

	  it "is not valid without a full_name" do
	  	subject.full_name = nil
	  	expect(subject).to_not be_valid
	  end

	  it "is not valid with full_name more than 50 characters" do
	  	subject.full_name = "a" * 51
	  	expect(subject).to_not be_valid
	  end

	  it "is not valid without a user_name" do
	  	subject.user_name = nil
	  	expect(subject).to_not be_valid
	  end

	  it "is not valid with user_name more than 20 characters" do
	  	subject.user_name = "a" * 21
	  	expect(subject).to_not be_valid
	  end

	  it "is not valid without a password" do
	  	subject.password = nil
	  	expect(subject).to_not be_valid
	  end
	  
	  it "is not valid without a password_confirmation" do
	  	subject.password_confirmation = nil
	  	expect(subject).to_not be_valid
	  end
	end

	describe "Associations" do
  	it "has one user stat" do
  		should have_one(:user_stat)
  	end
  end
end
