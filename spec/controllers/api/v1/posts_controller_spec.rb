RSpec.describe Api::V1::PostsController, type: :controller do
  let!(:question) { question = build(:post) }
  let(:tag) { tag = create(:tag) }

  before(:each) do
  	user = create(:user)
    user_auth = AuthHandler.new(user)
    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])
  end

  describe 'GET #index' do
    context 'when posts are present' do
      it 'returns list of posts' do
        question.save
        
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(question.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'posts are not present' do
      it 'returns empty list' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'when post is present' do
      it "returns post" do
        question.save
        get :show, params: { id: question.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(question.to_json)
      end
    end

    context 'when post is not present' do
      it 'raises not found error' do
        expect { get :show, params: { id: 300 } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new post' do
        post :create, params: { post: { title: 'Info', body: 'This is an informative post.', tag: tag} }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['id']).to eq(Post.last.id)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        expect { 
      		post :create, params: { post: { text: 'This is an informative post.' } } 
      	}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing post' do
        question.save
        put :update, params: { id: question.id, post: { body: 'This is an updated post.' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        question.save
        expect { 
        	put :update, params: { id: 300, post: { body: 'This is an updated post.' } }
      	}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the post' do
        question.save
        
        user = User.find(question.user_id)
		    user_auth = AuthHandler.new(user)
		    session = Session.create!(user: user_auth.authenticate('password', cookies), auth_token: cookies.signed[:auth_token])
        
        delete :destroy, params: { id: question.id }

        expect(response).to have_http_status(:no_content)
        expect(Post.find_by(id: question.id)).to eq(nil)
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
