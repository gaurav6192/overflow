describe PostStat do
  it "has a valid factory" do
    expect(build(:post_stat)).to be_valid
  end

  let(:post_stat) { build(:post_stat) }
  
  describe "ActiveModel validations" do
    it { expect(post_stat).to validate_presence_of(:score) }
    it { expect(post_stat).to validate_presence_of(:view_count) }
    it { expect(post_stat).to validate_presence_of(:post) }
  end

  describe "ActiveRecord associations" do
    it { expect(post_stat).to belong_to(:post) }
  end

  describe "default scope" do
    it "returns all post_stats with deleted_at nil" do
      post_stat = create(:post_stat)
      expect(post_stat.deleted_at).to eq(nil)
    end
  end
end
