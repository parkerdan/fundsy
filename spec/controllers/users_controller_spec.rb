require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "instansiates a new user model" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid params" do
      def valid_params
        {
          first_name: Faker::Name.first_name,
          last_name:  Faker::Name.last_name,
          email:      Faker::Internet.email,
          password:   "grimnitz",
          password_confirmation: "grimnitz"
        }
      end

      def valid_request
        post(:create, {user: valid_params})
      end

      it "adds User to db" do
        # count_before = User.count
        # post :create, {user: valid_params}
        # count_after = User.count
        # expect(count_after - count_before).to eq(1)
        expect { valid_request }.to change { User.count }.by(1)
      end

      it "redirects to home page" do
        valid_request
        expect(response).to redirect_to root_path
      end

      it "automatically signs user in" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid params" do

      def invalid_params
        {
          first_name: nil,
          last_name:  Faker::Name.last_name,
          email:      Faker::Internet.email,
          password:   nil,
          password_confirmation: "grimnitz"
        }
      end

      def invalid_request
        post(:create, {user: invalid_params})
      end


      it "doesn't create record" do
        expect { invalid_request }.not_to change { User.count }
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template :new

      end

      it "sets flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end

    end

  end

end
