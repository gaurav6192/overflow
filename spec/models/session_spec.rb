describe Session do
  it "has a valid factory" do
    expect(build(:session)).to be_valid
  end

  let(:session) { build(:session) }

  describe "ActiveModel validations" do
    it { expect(session).to validate_presence_of(:auth_token) }
    it { expect(session).to validate_uniqueness_of(:auth_token) }
    it { expect(session).to validate_presence_of(:user) }
  end

  describe "ActiveRecord associations" do
    it { expect(session).to belong_to(:user) }
  end

  describe "default scope" do
    it "returns all revisions with deleted_at nil" do
      session = create(:post_revision)
      expect(session.deleted_at).to eq(nil)
    end
  end
end
