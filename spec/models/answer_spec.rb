describe Answer do
  it "has a valid factory" do
    expect(build(:answer)).to be_valid
  end

  let(:answer) { build(:answer) }
  
  describe "ActiveModel validations" do
    it { expect(answer).to validate_presence_of(:body) }
    it { expect(answer).to validate_presence_of(:post) }
    it { expect(answer).to validate_presence_of(:user) }
  end

  describe "ActiveRecord associations" do
    it { expect(answer).to belong_to(:post) }
    it { expect(answer).to belong_to(:user) }
    it { expect(answer).to have_one(:answer_stat) }
  end

  describe "default scope" do
    it "returns all answers with deleted_at nil" do
      answer = create(:answer)
      expect(answer.deleted_at).to eq(nil)
    end
  end
end
