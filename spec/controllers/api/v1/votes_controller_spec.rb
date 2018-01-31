RSpec.describe Api::V1::VotesController, type: :controller do
  let(:answer_stat) { answer_stat = create(:answer_stat) }
  let(:vote_type) { vote_type = create(:super) }
  let!(:vote) { vote = build(:answer_vote) }

  before(:each) do
    user = create(:user)
    user_auth = AuthHandler.new(user)
    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])
  end

  describe 'GET #index' do
    context 'when votes are present for answer' do
      it 'returns list of votes' do
        vote.save
        
        get :index, params: { answer_id: AnswerStat.find(vote.voteable_id).answer_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(vote.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'answers are not present for post' do
      it 'returns empty list' do
        get :index, params: { answer_id: AnswerStat.find(vote.voteable_id).answer_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new vote' do
        post :create, params: { answer_id: answer_stat.answer_id, vote: { vote_type_id: vote_type.id } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['id']).to eq(answer_stat.votes.last.id)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        expect { 
          post :create, params: { answer_id: answer_stat.answer_id, vote: { vote_type_id: 500 } } 
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the answer' do
        user = User.find(vote.user_stat.user_id)
        user.user_stat = vote.user_stat
        user_auth = AuthHandler.new(user)
        session = Session.create!(user: user_auth.authenticate('password', cookies), auth_token: cookies.signed[:auth_token])

        vote.save
        
        delete :destroy, params: { answer_id: AnswerStat.find(vote.voteable_id).answer_id, id: vote.id }

        expect(response).to have_http_status(:no_content)
        expect(Vote.find_by(id: vote.id)).to eq(nil)
      end
    end

    context 'id given is not correct' do
      it 'raise a not found error' do
        expect { 
          delete :destroy, params: { answer_id: answer_stat.answer_id, id: 300 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
