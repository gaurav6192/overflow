describe User do
	it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }
  
  describe "ActiveModel validations" do
  	it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(user).to validate_length_of(:email).is_at_most(255) }
    it { expect(user).to validate_presence_of(:full_name) }
		it { expect(user).to validate_length_of(:full_name).is_at_most(100) }
    it { expect(user).to validate_presence_of(:user_name) }
    it { expect(user).to validate_uniqueness_of(:user_name).case_insensitive }
    it { expect(user).to validate_length_of(:user_name).is_at_most(50) }
    it { expect(user).to validate_presence_of(:password).ignoring_interference_by_writer }
		it { expect(user).to validate_length_of(:password).is_at_least(6) }
  end

  describe "ActiveRecord associations" do
    it { expect(user).to have_one(:user_stat) }
  end

  describe "default scope" do
    it "returns all users with deleted_at nil" do
      user = create(:user)
      expect(user.deleted_at).to eq(nil)
    end
  end
end
