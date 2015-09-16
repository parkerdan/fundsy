require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe "#create" do
    context "with valid credentials" do
      
    end

    context "with invalid credentials" do

    end

  end


  describe "#destroy" do

  end

end
