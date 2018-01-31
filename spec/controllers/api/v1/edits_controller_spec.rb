RSpec.describe Api::V1::EditsController, :type => :controller do
  let!(:edit) { edit = build(:edit) }
  let(:question) { question = create(:post) }
  
  describe 'GET #index' do
    context 'when edits are present for question' do
      it 'returns list of edits' do
        edit.save
        get :index, params: { post_id: edit.editable_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect([JSON.parse(edit.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'edits are not present for question' do
      it 'returns empty list' do
        get :index, params: { post_id: question.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

end
