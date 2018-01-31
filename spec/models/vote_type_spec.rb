describe VoteType do
  it "has a valid factory" do
    expect(build(:vote_type)).to be_valid
  end

  let(:vote_type) { build(:vote_type) }
  
  describe "ActiveModel validations" do
    it { expect(vote_type).to validate_presence_of(:name) }
    it { expect(vote_type).to validate_presence_of(:score_change) }
    it { expect(vote_type).to validate_uniqueness_of(:name).case_insensitive }
  end

  describe "ActiveRecord associations" do
    it { expect(vote_type).to have_many(:votes) }
  end

  describe "default scope" do
    it "returns all vote_types with deleted_at nil" do
      vote_type = create(:vote_type)
      expect(vote_type.deleted_at).to eq(nil)
    end
  end
end
