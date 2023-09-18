require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:valid_user_params) do
    {
      username: 'testuser',
      email: 'user@example.com',
      password: 'password',
      phone: '1234567890',
      role: 'User'
    }
  end

  let(:invalid_user_params) do
    {
      username: 'testuser12',
      email: 'user888@example.com',
      password: 'password@',
      phone: '12345678990',
      role: nil
    }
  end
#bundle exec rspec spec/controllers/api/users_controller_spec.rb
  describe 'GET #index' do
    it 'returns a list of users' do
      # Create some users for testing
      create(:user, username: 'user3')
      create(:user, username: 'user4')

      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(2) # Assuming 2 users were created
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        post :create, params: { user: valid_user_params }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Đăng ký thành công')
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post :create, params: { user: invalid_user_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end

  describe 'GET #show' do
    it 'returns user details' do
      user = create(:user)

      get :show, params: { id: user.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('username')
    end
  end

  describe 'PATCH #update' do
    context 'with admin user' do
      it 'updates user details' do
        admin_user = create(:user, role: 'Admin')
        user = create(:user)

        sign_in admin_user

        patch :update, params: { id: user.id, user: { username: 'new_username' } }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Cập nhật thành công')
        expect(User.find(user.id).username).to eq('new_username')
      end
    end

    context 'with non-admin user' do
      it 'returns forbidden' do
        user = create(:user)

        patch :update, params: { id: user.id, user: { username: 'new_username' } }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with admin user' do
      it 'destroys a user' do
        admin_user = create(:user, role: 'Admin')
        user = create(:user)

        sign_in admin_user

        delete :destroy, params: { id: user.id }

        expect(response).to have_http_status(:success)
        expect(User.exists?(user.id)).to be_falsey
      end
    end

    context 'with non-admin user' do
      it 'returns forbidden' do
        user = create(:user)

        delete :destroy, params: { id: user.id }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST #logout' do
    it 'logs out the user' do
      user = create(:user)

      sign_in user

      post :logout

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #current' do
    it 'returns current user details' do
      user = create(:user)

      sign_in user

      get :current

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('user_id')
      expect(JSON.parse(response.body)).to have_key('role')
    end

    it 'returns not found if no user is logged in' do
      get :current

      expect(response).to have_http_status(:not_found)
    end
  end
end