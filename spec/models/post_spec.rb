describe Post do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  let(:post) { build(:post) }
  
  describe "ActiveModel validations" do
  	it { expect(post).to validate_presence_of(:title) }
    it { expect(post).to validate_presence_of(:body) }
    it { expect(post).to validate_presence_of(:user) }
  end

  describe "ActiveRecord associations" do
    it { expect(post).to belong_to(:user) }
    it { expect(post).to have_one(:post_stat) }
  end

  describe "default scope" do
    it "returns all posts with deleted_at nil" do
      post = create(:post)
      expect(post.deleted_at).to eq(nil)
    end
  end

  describe "post with answers" do
    it "returns post with 5 answers" do
      post = create(:post, :with_answers)
      expect(post.answers.size).to eq(5)
    end
  end
end
