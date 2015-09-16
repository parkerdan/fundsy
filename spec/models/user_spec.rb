require 'rails_helper'


#DSL: Domain Specific Language is below, this is RSpec's syntax
RSpec.describe User, type: :model do

  def valid_attributes(new_attributes = {})
    {first_name: "Tom",
     last_name:  "Smith",
     email:      "tom@smith.com",
     password:   "grimnitz"
   }.merge(new_attributes)

  end


  describe "Validations" do
    it "requires an emial" do
      user = User.new valid_attributes({email: nil})
      expect(user).to be_invalid
    end

    it "requires a first_name" do
      user = User.new valid_attributes({first_name: nil})
      user.email = "something@something.com"
      expect(user).to be_invalid
    end

    it "requires a password" do
      user = User.new valid_attributes({password: nil})
      user.save
      expect(user.errors.messages).to have_key(:password)
    end

    it "requires an email with valid format" do
      user = User.new valid_attributes({email: "dslcndljsVs"})
      user.save
      expect(user.errors.messages).to have_key(:email)
    end

  end

  describe ".full_name" do
    it "returns the first name and last name if given" do
      user = User.new(valid_attributes)
      expect(user.full_name).to eq("Tom Smith")
    end

    it "returns first name only if last name is missing" do
      user = User.new valid_attributes({last_name: nil})
      expect(user.full_name).to eq("Tom")
    end
  end

  describe "generating password hash" do
    it "generates a password digest" do
      user = User.new valid_attributes
      user.save
      expect(user.password_digest).to be
    end
  end



end
