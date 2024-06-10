require 'rspec'
require './lib/card'
require './lib/deck'

RSpec.describe Deck do 
  before :each do 
    @cards = []
    suits = [:diamond, :heart, :club, :spade]
    values = [
      ['1', 1], ['2', 2], ['3', 3], ['4', 1], ['5', 2], ['6', 3], ['7', 1], 
      ['8', 2], ['9', 3], ['10', 10], ['Jack', 11], ['Queen', 12], ['King', 13], ['Ace', 14]
    ]
    
    suits.each do |suit|
      values.each do |value, rank|
        @cards << Card.new(suit, value, rank)
      end
    end
  end

  it "exists" do 
    expect(@cards).to be_an_instance_of(Array)
    deck = Deck.new(@cards)
    expect(deck).to be_an_instance_of(Deck)
    expect(deck.cards).to be_an_instance_of(Array)
    # require 'pry'; binding.pry
    expect(deck.cards[0]).to be_an_instance_of(Card)
    expect(deck.cards[55]).to be_an_instance_of(Card)
    expect(deck.cards.size).to eq(56)
  end
end