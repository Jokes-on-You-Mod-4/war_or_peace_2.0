require 'spec_helper'

RSpec.describe CardGenerator do

  describe "#initialize" do 
    it "exists" do 
      filename = "cards.txt"
      card_gen = CardGenerator.new(filename)
      # require 'pry'; binding.pry
      expect(card_gen).to be_an_instance_of CardGenerator
    end
  end

  describe "#cards" do 
    it "it converts the txt data into an array of Card objects" do
      filename = "cards.txt"
      cards = CardGenerator.new(filename).cards
      # require 'pry'; binding.pry
      expect(cards).to be_an_instance_of Array
      expect(cards[0]).to be_an_instance_of Card
      # require 'pry'; binding.pry
      expect(cards.size).to eq 52
      expect(cards[51].suit).to eq "Spade"
      expect(cards[51].rank).to eq 14
      expect(cards[51].value).to eq "Ace"
    end
  end
end