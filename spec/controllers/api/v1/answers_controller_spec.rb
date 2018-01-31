RSpec.describe Api::V1::AnswersController, type: :controller do
  let(:question) { post = create(:post) }
  let!(:answer) { answer = build(:answer) }

  before(:each) do
  	user = create(:user)
    user_auth = AuthHandler.new(user)
    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])
  end

  describe 'GET #index' do
    context 'when answers are present for post' do
      it 'returns list of answers' do
        answer.save
        
        get :index, params: { post_id: answer.post_id, user_id: answer.user_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(answer.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'answers are not present for post' do
      it 'returns empty list' do
        get :index, params: { post_id: answer.post_id, user_id: answer.user_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'when answer is present' do
      it "returns answer" do
        answer.save
        get :show, params: { id: answer.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(answer.to_json)
      end
    end

    context 'when answer is not present' do
      it 'raises not found error' do
        expect { get :show, params: { id: 300 } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new answer' do
        post :create, params: { post_id: question.id, answer: { body: 'This is an informative answer.' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['id']).to eq(question.answers.last.id)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        expect { 
      		post :create, params: { post_id: question.id, answer: { text: 'This is an informative answer.' } } 
      	}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing answer' do
        answer.save
        put :update, params: { post_id: answer.post_id, id: answer.id, answer: { text: 'This is an updated answer.' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        answer.save
        expect { 
        	put :update, params: { id: 300, post_id: answer.post_id, answer: { name: 'Gaurav Verma' } }
      	}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the answer' do
        answer.save
        user = User.find(answer.user_id)
		    user_auth = AuthHandler.new(user)
		    session = Session.create!(user: user_auth.authenticate('password', cookies), auth_token: cookies.signed[:auth_token])
        delete :destroy, params: { post_id: answer.post_id, id: answer.id }

        expect(response).to have_http_status(:no_content)
        expect(Answer.find_by(id: answer.id)).to eq(nil)
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
