describe Tag do
  it "has a valid factory" do
    expect(build(:tag)).to be_valid
  end

  let(:tag) { build(:tag) }
  
  describe "ActiveModel validations" do
    it { expect(tag).to validate_presence_of(:title) }
    it { expect(tag).to validate_uniqueness_of(:title).case_insensitive }
  end

  describe "ActiveRecord associations" do
    it { expect(tag).to have_and_belong_to_many(:posts) }
    it { expect(tag).to have_and_belong_to_many(:users) }
  end

  describe "default scope" do
    it "returns all tags with deleted_at nil" do
      tag = create(:tag)
      expect(tag.deleted_at).to eq(nil)
    end
  end
end
