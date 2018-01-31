describe Edit do
  it "has a valid factory" do
    expect(build(:edit)).to be_valid
  end

  let(:edit) { build(:edit) }

  describe "ActiveModel validations" do
    it { expect(edit).to validate_presence_of(:editable_content) }
    it { expect(edit).to validate_presence_of(:score) }
    it { expect(edit).to validate_presence_of(:user) }
  end

  describe "ActiveRecord associations" do
    it { expect(edit).to belong_to(:editable) }
    it { expect(edit).to belong_to(:user) }
    it { expect(answer).to have_one(:edit_stat) }
  end

  describe "default scope" do
    it "returns all edits with deleted_at nil" do
      edit = create(:edit)
      expect(edit.deleted_at).to eq(nil)
    end
  end

  describe "revised" do
    it "returns edit with a revision" do
      edit = create(:edit, :revised)
      expect(edit.revision).to_not eq(nil)
    end
  end
end
