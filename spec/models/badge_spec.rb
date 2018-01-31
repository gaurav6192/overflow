describe Badge do
  it "has a valid factory" do
    expect(build(:badge)).to be_valid
  end

  let(:badge) { build(:badge) }
  
  describe "ActiveModel validations" do
    it { expect(badge).to validate_presence_of(:name) }
    it { expect(badge).to validate_uniqueness_of(:name).case_insensitive }
  end

  describe "ActiveRecord associations" do
    it { expect(badge).to have_and_belong_to_many(:users) }
  end

  describe "default scope" do
    it "returns all badges with deleted_at nil" do
      badge = create(:badge)
      expect(badge.deleted_at).to eq(nil)
    end
  end
end
