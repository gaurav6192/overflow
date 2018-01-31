RSpec.describe Api::V1::TagsController, type: :controller do
  let!(:tag) { tag = build(:tag) }

  before(:each) do
  	user = create(:user)
    user_auth = AuthHandler.new(user)
    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])
  end

  describe 'GET #index' do
    context 'when tags are present' do
      it 'returns list of tags' do
        tag.save
        
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(tag.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'when tags are not present' do
      it 'returns empty list' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'when tag is present' do
      it "returns tag" do
        tag.save
        
        get :show, params: { id: tag.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(tag.to_json)
      end
    end

    context 'when tag is not present' do
      it 'raises not found error' do
        expect { get :show, params: { id: 300 } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new tag' do
      	post :create, params: { tag: { title: 'Info' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['id']).to eq(Tag.last.id)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        expect { 
      		post :create, params: { tag: { name: 'This is an informative tag.' } } 
      	}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing tag' do
      	tag.save

      	put :update, params: { id: tag.id, tag: { title: 'Updates' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        tag.save
        expect { 
        	put :update, params: { id: 300, tag: { name: 'Gaurav Verma' } }
      	}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the tag' do
        tag.save
        delete :destroy, params: { id: tag.id }

        expect(response).to have_http_status(:no_content)
        expect(Tag.find_by(id: tag.id)).to eq(nil)
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
