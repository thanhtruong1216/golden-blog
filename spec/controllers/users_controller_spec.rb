require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'populates an array of user' do
      user = FactoryBot.create(:user)
      sign_in user
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it 'renders the :index view' do
      user = FactoryBot.create(:user)
      sign_in user
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      user = FactoryBot.create(:user)
      sign_in user
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the #show view' do
      user = FactoryBot.create(:user)
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to render_template('show')
    end
  end
end
