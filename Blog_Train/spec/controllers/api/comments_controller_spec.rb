require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, role: 'Admin') }
  let(:comment) { create(:comment, user: user) }
  let(:post) { create(:post) }

  before do
    # Stub the authentication for Devise controllers
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a list of comments' do
      comment1 = create(:comment)
      comment2 = create(:comment)

      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(Comment.count)
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      it 'creates a new comment' do
        valid_attributes = { content: 'New Comment', post_id: post.id, user_id: user.id }

        expect {
          post :create, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'returns the created comment' do
        valid_attributes = { content: 'New Comment', post_id: post.id, user_id: user.id }

        post :create, params: { comment: valid_attributes }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('id', 'content', 'user', 'post_id')
      end

      it 'assigns the current user as the comment owner' do
        valid_attributes = { content: 'New Comment', post_id: post.id, user_id: user.id }

        post :create, params: { comment: valid_attributes }

        created_comment = Comment.last
        expect(created_comment.user).to eq(user)
      end

      it 'returns unprocessable_entity status if comment is invalid' do
        invalid_attributes = { content: nil, post_id: post.id, user_id: user.id }

        post :create, params: { comment: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not authenticated' do
      it 'returns forbidden status' do
        valid_attributes = { content: 'New Comment', post_id: post.id, user_id: user.id }

        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
        allow(controller).to receive(:current_user).and_return(nil)

        post :create, params: { comment: valid_attributes }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a specific comment' do
      get :show, params: { id: comment.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(comment.id)
    end

    it 'returns not found status if the comment does not exist' do
      get :show, params: { id: 999 }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is the comment owner' do
      it 'deletes a comment' do
        comment_to_delete = create(:comment, user: user)

        expect {
          delete :destroy, params: { id: comment_to_delete.id }
        }.to change(Comment, :count).by(-1)

        expect(response).to have_http_status(:ok)
      end

      it 'returns forbidden status if the comment does not exist' do
        delete :destroy, params: { id: 999 }

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is not the comment owner' do
      let(:comment_owner) { create(:user) }

      it 'returns forbidden status' do
        comment_to_delete = create(:comment, user: comment_owner)

        delete :destroy, params: { id: comment_to_delete.id }

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is an admin' do
      it 'deletes a comment' do
        comment_to_delete = create(:comment)

        allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
        allow(controller).to receive(:current_user).and_return(admin)

        expect {
          delete :destroy, params: { id: comment_to_delete.id }
        }.to change(Comment, :count).by(-1)

        expect(response).to have_http_status(:ok)
      end
    end
  end


end
