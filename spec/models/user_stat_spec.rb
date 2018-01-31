describe UserStat do
  it "has a valid factory" do
    expect(build(:user_stat)).to be_valid
  end

  let(:user_stat) { build(:user_stat) }
  
  describe "ActiveModel validations" do
    it { expect(user_stat).to validate_presence_of(:reputation_count) }
    it { expect(user_stat).to validate_presence_of(:user) }
  end

  describe "ActiveRecord associations" do
    it { expect(user_stat).to belong_to(:user) }
  end

  describe "default scope" do
    it "returns all user_stats with deleted_at nil" do
      user_stat = create(:user_stat)
      expect(user_stat.deleted_at).to eq(nil)
    end
  end
end
