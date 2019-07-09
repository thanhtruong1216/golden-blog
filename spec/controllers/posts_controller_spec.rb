require 'rails_helper'
require 'spec_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'populates an array of post' do
      post = FactoryBot.create(:post)
      user = post.user
      sign_in user
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it 'renders the :index view' do
      post = FactoryBot.create(:post)
      sign_in post.user
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post to @post' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      sign_in post.user
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end

    it 'renders the #show view' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      sign_in post.user
      get :show, params: { id: post.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'render new template' do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST #create' do
    it "creates a new post" do
      user = FactoryBot.create(:user)
      new_post = FactoryBot.build(:post, user: user)
      sign_in user
      expect(Post).to receive(:new).and_return(new_post)
      post :create, params: { post: { content: new_post.content, photo: 'photo.jpg' } }
      expect(assigns[:post].attributes).to eq(new_post.attributes)
    end

    it "redirects to the new post path" do
      user = FactoryBot.create(:user)
      new_post = FactoryBot.build(:post, user: user)
      posts = Post.all
      sign_in user
      expect(Post).to receive(:new).and_return(new_post)
      post :create, params: { post: { content: new_post.content, photo: 'photo.jpg' } }
      expect(response).to redirect_to Post.last
    end
  end
end
