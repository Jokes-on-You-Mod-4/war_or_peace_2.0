class Game


  attr_reader :cards,
              :player1_deck,
              :player2_deck,
              :player1,
              :player2


  def initialize
    @cards = standard_deck_cards
    @player1_deck = []
    @player2_deck = []
    @player1 = nil
    @player2 = nil

  end

  def standard_deck_cards
    unshuffled_cards = []
    suits = [:diamond, :heart, :club, :spade]
    values = [
      ['2', 2], ['3', 3], ['4', 4], ['5', 5], ['6', 6], ['7', 7], 
      ['8', 8], ['9', 9], ['10', 10], ['Jack', 11], ['Queen', 12], ['King', 13], ['Ace', 14]
    ]
    suits.each do |suit|
      values.each do |value, rank|
        unshuffled_cards << Card.new(suit, value, rank)
      end
    end
    unshuffled_cards
  end

  def shuffle_cards
    @cards.shuffle
    player1_cards = []
    player2_cards = []
    pointer = 0
    @cards.map do |card|
      pointer.even? ? player1_cards << card : player2_cards << card
      pointer += 1
    end

    @player1_deck = Deck.new(player1_cards)
    @player2_deck = Deck.new(player2_cards)
  end

  def make_computer_players
    
  end

  # def make_player1(name, deck)
  #   @player1 = Player.new(name, deck)
  # end

  # def make_player2(name, deck)
  #   @player2 = Player.new(name, deck)
  # end





end