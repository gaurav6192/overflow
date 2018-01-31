RSpec.describe Api::V1::RevisionsController, :type => :controller do
  let!(:revision) { revision = build(:revision) }
  let(:question) { question = create(:post) }
  
  describe 'GET #index' do
    context 'when revisions are present for question' do
      it 'returns list of revisions' do
        revision.save
        get :index, params: { post_id: revision.revisionable_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect([JSON.parse(revision.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'revisions are not present for question' do
      it 'returns empty list' do
        get :index, params: { post_id: question.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

end
