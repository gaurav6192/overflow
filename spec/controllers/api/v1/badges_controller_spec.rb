RSpec.describe Api::V1::BadgesController, type: :controller do
  let!(:badge) { badge = build(:badge) }

  before(:each) do
  	user = create(:user)
    user_auth = AuthHandler.new(user)
    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])
  end

  describe 'GET #index' do
    context 'when badges are present' do
      it 'returns list of badges' do
        badge.save
        
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(badge.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'when badges are not present' do
      it 'returns empty list' do
        get :index
        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'when badge is present' do
      it "returns badge" do
        badge.save
        get :show, params: { id: badge.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(badge.to_json)
      end
    end

    context 'when badge is not present' do
      it 'raises not found error' do
        expect { get :show, params: { id: 300 } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new badge' do
        post :create, params: { badge: { name: 'Info', about: 'This is an informative badge.' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['id']).to eq(Badge.last.id)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        expect { 
      		post :create, params: { badge: { title: 'This is an informative badge.' } } 
      	}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing badge' do
        badge.save
        put :update, params: { id: badge.id, badge: { body: 'This is an updated badge.' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        badge.save
        expect { 
        	put :update, params: { id: 300, badge: { name: 'Gaurav Verma' } }
      	}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the badge' do
        badge.save
        delete :destroy, params: { id: badge.id }

        expect(response).to have_http_status(:no_content)
        expect(Badge.find_by(id: badge.id)).to eq(nil)
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
