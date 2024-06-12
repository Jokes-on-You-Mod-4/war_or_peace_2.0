
require 'spec_helper'

RSpec.describe Deck do 
  before :each do 
    @cards = []
    suits = [:diamond, :heart, :club, :spade]
    values = [
      ['2', 2], ['3', 3], ['4', 4], ['5', 5], ['6', 6], ['7', 7], 
      ['8', 8], ['9', 9], ['10', 10], ['Jack', 11], ['Queen', 12], ['King', 13], ['Ace', 14]
    ]
    suits.each do |suit|
      values.each do |value, rank|
        @cards << Card.new(suit, value, rank)
      end
    end
  end

  describe "#new" do 
    it "exists" do 
      expect(@cards).to be_an_instance_of(Array)
      deck = Deck.new(@cards)
      expect(deck).to be_an_instance_of(Deck)
      expect(deck.cards).to be_an_instance_of(Array)
      expect(deck.cards[0]).to be_an_instance_of(Card)
      expect(deck.cards[51]).to be_an_instance_of(Card)
      expect(deck.cards.size).to eq(52)
    end
  end

  describe "#rank_of_card_at" do 
    it "checks the rank of a card" do 
      card1 = Card.new(:diamond, "Queen", 12)
      card2 = Card.new(:spade, "3", 3)
      card3 = Card.new(:heart, "Ace", 14)
      cards = [card1, card2, card3]
      deck = Deck.new(cards)

      expect(deck.rank_of_card_at(0)).to eq(12)
      expect(deck.rank_of_card_at(2)).to eq(14)
      expect(deck.cards).to eq([card1, card2, card3])
    end
  end

  describe "#high_ranking_cards" do 
    it "displays the cards with the ranking above 11 in an array" do 
      card1 = Card.new(:diamond, "Queen", 12)
      card2 = Card.new(:spade, "3", 3)
      card3 = Card.new(:heart, "Ace", 14)
      cards = [card1, card2, card3]
      deck = Deck.new(cards)

      expect(deck.high_ranking_cards).to be_an_instance_of(Array)
      expect(deck.high_ranking_cards).to eq([card1, card3])
      expect(deck.high_ranking_cards[0]).to be_an_instance_of(Card)
    end
  end

  describe "#percent_high_rankings" do 
    it "displays the percentage of the deck with cards ranking above 11 or greater" do 
      card1 = Card.new(:diamond, "Queen", 12)
      card2 = Card.new(:spade, "3", 3)
      card3 = Card.new(:heart, "Ace", 14)
      cards = [card1, card2, card3]
      deck = Deck.new(cards)

      expect(deck.percent_high_ranking).to eq(66.67)
    end
  end

  describe "#remove_card" do 
    it "removes the first card from the player's deck" do 
      card1 = Card.new(:diamond, "Queen", 12)
      card2 = Card.new(:spade, "3", 3)
      card3 = Card.new(:heart, "Ace", 14)
      cards = [card1, card2, card3]
      deck = Deck.new(cards)

      expect(deck.remove_card).to eq card1
      expect(deck.cards).to eq [card2, card3]
      expect(deck.high_ranking_cards).to eq [card3]
      expect(deck.percent_high_ranking).to eq 50.0
    end
  end

  describe "#add_card" do 
    it "adds a card to the end of a player's deck" do 
      card2 = Card.new(:spade, "3", 3)
      card3 = Card.new(:heart, "Ace", 14)
      cards = [card2, card3]
      deck = Deck.new(cards)

      expect(deck.cards).to eq([card2, card3])
      card4 = Card.new(:club, '5', 5)
      deck.add_card(card4)
      expect(deck.cards).to eq([card2, card3, card4])
      expect(deck.percent_high_ranking).to eq 33.33
    end
  end
end
