require 'spec_helper'

RSpec.describe Game do
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
  describe "#initialize" do
    it "exists" do
      game = Game.new

      expect(game).to be_an_instance_of(Game)
    end

    it "has readable attributes" do
      game = Game.new
      expect(game.cards).to be_an_instance_of(Array)

      expect(game.cards).to be_an_instance_of(Array)
      expect(game.cards[0]).to be_an_instance_of(Card)
      expect(game.cards[51]).to be_an_instance_of(Card)
      expect(game.cards.size).to eq(52)

      expect(game.player1_deck).to eq []
      expect(game.player2_deck).to eq []

      expect(game.player1).to eq nil
      expect(game.player2).to eq nil
    end
  end

  describe "#standard_deck_cards" do 
    it "makes an array of card objects respresenting a standard 52 card deck" do 
      game = Game.new

      expect(game.standard_deck_cards).to be_an_instance_of(Array)
      expect(game.standard_deck_cards[0]).to be_an_instance_of(Card)
      expect(game.standard_deck_cards[51]).to be_an_instance_of(Card)
      expect(game.standard_deck_cards.size).to eq(52)
    end
  end

  describe '#shuffle_cards' do
    it "splits randomized cards into two separate player card decks" do 
      game = Game.new

      expect(game.player1_deck).to eq []
      expect(game.player2_deck).to eq []

      game.shuffle_cards

      expect(game.player1_deck.cards.size).to eq 26
      expect(game.player2_deck.cards.size).to eq 26

      expect(game.player1_deck).to be_an_instance_of Deck
      expect(game.player1_deck.cards[0]).to be_an_instance_of Card
    end
  end

  describe "#make_computer_players" do 
    it "generates two computer players" do
      game = Game.new
      expect(game.player1).to eq nil
      expect(game.player2).to eq nil
      
      game.shuffle_cards
      game.make_computer_players

      expect(game.player1).to be_an_instance_of Player
      expect(game.player1.name).to eq "Megan"
      expect(game.player1.deck.cards.size).to eq 26

      expect(game.player2).to be_an_instance_of Player
      expect(game.player2.name).to eq "Aurora"
      expect(game.player2.deck.cards.size).to eq 26
    end
  end

  describe "#start" do 
    it "begins and completes a game simulation" do 
      game = Game.new

      game.shuffle_cards
      game.make_computer_players

      # expect(game.start).to eq []
    end
  end


end
