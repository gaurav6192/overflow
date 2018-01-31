describe AnswerStat do
  it "has a valid factory" do
    expect(build(:answer_stat)).to be_valid
  end

  let(:answer_stat) { build(:answer_stat) }
  
  describe "ActiveModel validations" do
    it { expect(answer_stat).to validate_presence_of(:score) }
    it { expect(answer_stat).to validate_presence_of(:view_count) }
    it { expect(answer_stat).to validate_presence_of(:answer) }
  end

  describe "ActiveRecord associations" do
    it { expect(answer_stat).to belong_to(:answer) }
  end

  describe "default scope" do
    it "returns all answer_stats with deleted_at nil" do
      answer_stat = create(:answer_stat)
      expect(answer_stat.deleted_at).to eq(nil)
    end
  end
end
