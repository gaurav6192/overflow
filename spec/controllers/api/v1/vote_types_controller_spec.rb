RSpec.describe Api::V1::VoteTypesController, type: :controller do
  let!(:vote_type) { vote_type = build(:vote_type) }

  before(:each) do
    user = create(:user)
    user_auth = AuthHandler.new(user)
    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])
  end

  describe 'GET #index' do
    context 'when vote_types are present' do
      it 'returns list of vote_types' do
        vote_type.save
        
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(vote_type.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'when vote_types are not present' do
      it 'returns empty list' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'when vote_type is present' do
      it "returns vote_type" do
        vote_type.save
        get :show, params: { id: vote_type.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(vote_type.to_json)
      end
    end

    context 'when vote_type is not present' do
      it 'raises not found error' do
        expect { get :show, params: { id: 300 } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new vote_type' do
        post :create, params: { vote_type: { name: 'SuperUp', score_change: 2 } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['id']).to eq(VoteType.last.id)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        expect { 
          post :create, params: { vote_type: { title: 'This is an informative vote_type.' } } 
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing vote_type' do
        vote_type.save
        put :update, params: { id: vote_type.id, vote_type: { score_change: 3 } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        vote_type.save
        expect { 
          put :update, params: { id: 300, vote_type: { name: 'Gaurav Verma' } }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the vote_type' do
        vote_type.save
        delete :destroy, params: { id: vote_type.id }

        expect(response).to have_http_status(:no_content)
        expect(VoteType.find_by(id: vote_type.id)).to eq(nil)
      end
    end

    context 'id given is not correct' do
      it 'raise a not found error' do
        expect { 
          delete :destroy, params: { id: 300 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end