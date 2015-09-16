require 'rails_helper'

RSpec.describe Campaign, type: :model do

  def valid_attributes(new_attributes = {})
    {title:       "Cat Swing",
     end_date:    "tomorrow",
     description: "awesome",
     goal:            15
   }.merge(new_attributes)

  end




  describe "Validations" do

    it "has a title" do
      campaign = Campaign.new valid_attributes({title: nil})
      expect(campaign).to be_invalid

    end

    it "has a goal" do
      campaign = Campaign.new valid_attributes({goal: nil})
      expect(campaign).to be_invalid
    end

    it "has lots of ducats for a goal" do
      campaign = Campaign.new valid_attributes({goal: 9})
      expect(campaign).to be_invalid
    end

    it "has a description" do
      campaign = Campaign.new valid_attributes({description: nil})
      expect(campaign).to be_invalid
    end

    it "has a unique title" do
      campaign = Campaign.create valid_attributes
      campaign2 = Campaign.new valid_attributes
      expect(campaign2).to be_invalid
    end

  end
end
