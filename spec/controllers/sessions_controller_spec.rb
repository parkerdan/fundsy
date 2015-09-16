require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
# in config allowed FactoryGirl helpers
  let(:user) { create(:user) }


  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe "#create" do
    context "with valid credentials" do


      before do
        post(:create, {email: user.email, password: user.password})
      end

      it "sets the session id to the user id" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to home page" do
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        expect(flash[:notice]).to be
      end
    end

    context "with invalid credentials" do

      before do
        post(:create, {email: user.email, password: user.password + "g"})
      end

      it "doesn't set session id" do
        expect(session[:user_id]).not_to be
      end

      it "renders new template" do
        expect(response).to render_template(:new)
      end
      it "sets flash" do
        expect(flash[:alert]).to be
      end
    end

  end


  describe "#destroy" do
    before do
      login(user)
      delete :destroy
    end
    it "set the session[:user_id] to nil" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to home page" do
      expect(response).to redirect_to(root_path)
    end
    it "sets flash message" do
      expect(flash[:notice]).to be
    end

  end

end
