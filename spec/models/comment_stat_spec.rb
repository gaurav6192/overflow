describe CommentStat do
  it "has a valid factory" do
    expect(build(:comment_stat)).to be_valid
  end

  let(:comment_stat) { build(:comment_stat) }
  
  describe "ActiveModel validations" do
    it { expect(comment_stat).to validate_presence_of(:score) }
    it { expect(comment_stat).to validate_presence_of(:comment) }
  end

  describe "ActiveRecord associations" do
    it { expect(comment_stat).to belong_to(:comment) }
  end

  describe "default scope" do
    it "returns all comment_stats with deleted_at nil" do
      comment_stat = create(:comment_stat)
      expect(comment_stat.deleted_at).to eq(nil)
    end
  end
end
