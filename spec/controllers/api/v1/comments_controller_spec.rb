RSpec.describe Api::V1::CommentsController, :type => :controller do
  let!(:comment) { comment = build(:comment) }
  let(:question) { question = create(:post) }
  
  before(:each) do
  	user = create(:user)
    user_auth = AuthHandler.new(user)
    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])
  end

  describe 'GET #index' do
    context 'when comments are present for question' do
      it 'returns list of comments' do
        comment.save
        get :index, params: { post_id: comment.commentable_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect([JSON.parse(comment.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'comments are not present for question' do
      it 'returns empty list' do
        get :index, params: { post_id: question.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new comment' do
        post :create, params: { post_id: question.id, comment: { content: 'This is an informative comment.' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq(question.comments.last.id)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        expect { 
        	post :create, params: { post_id: question.id, comment: { author: 'Gaurav Verma' } }
      	}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing comment' do
        comment.save

        user = User.find(comment.user_id)
		    user_auth = AuthHandler.new(user)
		    session = Session.create!(user: user_auth.authenticate('password', cookies), auth_token: cookies.signed[:auth_token])

        put :update, params: { post_id: comment.commentable_id, id: comment.id, comment: { content: 'This is an updated comment.' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        expect { 
        	put :update, params: { id: 300, post_id: comment.commentable_id, comment: { author: 'Gaurav Verma' } }
      	}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the comment' do
        comment.save
        
        user = User.find(comment.user_id)
		    user_auth = AuthHandler.new(user)
		    session = Session.create!(user: user_auth.authenticate('password', cookies), auth_token: cookies.signed[:auth_token])

        delete :destroy, params: { id: comment.id, post_id: comment.commentable_id }

        expect(response).to have_http_status(:no_content)
        expect(Comment.find_by(id: comment.id)).to eq(nil)
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        expect {
        	delete :destroy, params: { id: 300, post_id: comment.commentable_id }
      	}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
