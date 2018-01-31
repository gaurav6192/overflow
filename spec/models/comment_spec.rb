describe Comment do
  it "has a valid factory" do
    expect(build(:post_comment)).to be_valid
  end

  let(:comment) { build(:post_comment) }

  describe "ActiveModel validations" do
    it { expect(comment).to validate_presence_of(:content) }
    it { expect(comment).to validate_presence_of(:user) }
  end

  describe "ActiveRecord associations" do
    it { expect(comment).to belong_to(:commentable) }
    it { expect(comment).to belong_to(:user) }
    it { expect(comment).to have_one(:comment_stat) }
  end

  describe "default scope" do
    it "returns all comments with deleted_at nil" do
      comment = create(:post_comment)
      expect(comment.deleted_at).to eq(nil)
    end
  end
end
