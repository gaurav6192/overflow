describe EditStat do
  it "has a valid factory" do
    expect(build(:edit_stat)).to be_valid
  end

  let(:edit_stat) { build(:edit_stat) }
  
  describe "ActiveModel validations" do
    it { expect(edit_stat).to validate_presence_of(:score) }
    it { expect(edit_stat).to validate_presence_of(:edit) }
  end

  describe "ActiveRecord associations" do
    it { expect(edit_stat).to belong_to(:edit) }
  end

  describe "default scope" do
    it "returns all edit_stats with deleted_at nil" do
      edit_stat = create(:edit_stat)
      expect(edit_stat.deleted_at).to eq(nil)
    end
  end
end
