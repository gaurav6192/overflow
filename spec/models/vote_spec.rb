describe Vote do
  it "has a valid factory" do
    expect(build(:vote)).to be_valid
  end

  let(:vote) { build(:vote) }

  describe "ActiveModel validations" do
    it { expect(vote).to validate_presence_of(:user_stat) }
    it { expect(vote).to validate_presence_of(:vote_type) }
  end

  describe "ActiveRecord associations" do
    it { expect(vote).to belong_to(:voteable) }
    it { expect(vote).to belong_to(:user_stat) }
    it { expect(vote).to belong_to(:vote_type) }
  end

  describe "default scope" do
    it "returns all votes with deleted_at nil" do
      vote = create(:vote)
      expect(vote.deleted_at).to eq(nil)
    end
  end
end
