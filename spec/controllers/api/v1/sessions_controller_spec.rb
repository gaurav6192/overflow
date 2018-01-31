RSpec.describe Api::V1::SessionsController, :type => :controller do
  let(:user) { user = create(:user) }
  let(:session) { session = create(:session) }

  describe 'post #login' do
    context 'when email and password are correct' do
      it 'sets auth_token and user_id in cookie' do
        post :create, params: { user: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:created)
        expect(cookies.signed[:user_id]).to eq(user.id)
        expect(cookies.signed[:auth_token]).to eq(Session.find_by(user_id: user.id).auth_token)
      end
    end

    context 'when email and password are not correct' do
      it 'responds with unauthorized error' do
        expect {
          post :create, params: { user: { email: user.email, password: 'Ppassword' } }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is already logged in' do
      it 'responds with logged in error' do
        
      	user_auth = AuthHandler.new(user)
		    session = Session.create!(user: user_auth.authenticate(user.password, cookies), auth_token: cookies.signed[:auth_token])

        post :create, params: { user: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:forbidden)
        expect(cookies.signed[:user_id]).to eq(session.user_id)
        expect(cookies.signed[:auth_token]).to eq(session.auth_token)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      it 'deletes cookie and logs user out' do
        cookies.signed[:user_id] = session.user_id
        cookies.signed[:auth_token] = session.auth_token
        delete :destroy, params: { id: session.id }

        expect(response).to have_http_status(:no_content)
        expect(Session.find_by(auth_token: session.auth_token)).to eq(nil)
        expect(response.cookies[:user_id]).to eq(nil)
        expect(response.cookies[:auth_token]).to eq(nil)
      end
    end
  end
end