describe Revision do
  it "has a valid factory" do
    expect(build(:post_revision)).to be_valid
  end

  let(:revision) { build(:post_revision) }

  describe "ActiveModel validations" do
    it { expect(revision).to validate_presence_of(:revisionable_content) }
    it { expect(revision).to validate_presence_of(:user) }
  end

  describe "ActiveRecord associations" do
    it { expect(revision).to belong_to(:revisionable) }
    it { expect(revision).to belong_to(:edit) }
    it { expect(revision).to belong_to(:user) }
  end

  describe "default scope" do
    it "returns all revisions with deleted_at nil" do
      revision = create(:post_revision)
      expect(revision.deleted_at).to eq(nil)
    end
  end
end
