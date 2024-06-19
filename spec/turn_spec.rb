
require 'spec_helper'

RSpec.describe Turn do
  before :each do
  # :basic
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @megan = Player.new("Megan", @deck1)
    @aurora = Player.new("Aurora", @deck2)
    @basic_turn = Turn.new(@megan, @aurora)

  # :war
    @card9 = Card.new(:heart, 'Jack', 11)    
    @card10 = Card.new(:heart, '10', 10)    
    @card11 = Card.new(:heart, '9', 9)    
    @card12 = Card.new(:diamond, 'Jack', 11)    
    @card13 = Card.new(:heart, '8', 8)    
    @card14 = Card.new(:diamond, 'Queen', 12)    
    @card15 = Card.new(:heart, '3', 3)    
    @card16 = Card.new(:diamond, '2', 2)    
    @deck3 = Deck.new([@card9, @card10, @card13, @card16])    
    @deck4 = Deck.new([@card12, @card11, @card14, @card15])    
    @sam = Player.new("Sam", @deck3)    
    @dan = Player.new("Dan", @deck4)    
    @war_turn = Turn.new(@sam, @dan)

  # :mutual_assured_destruction
    @card17 = Card.new(:heart, 'Jack', 11)    
    @card18 = Card.new(:heart, '10', 10)    
    @card19 = Card.new(:heart, '9', 9)    
    @card20 = Card.new(:diamond, 'Jack', 11)    
    @card21 = Card.new(:heart, '8', 8)    
    @card22 = Card.new(:diamond, '8', 8)    
    @card23 = Card.new(:heart, '3', 3)    
    @card24 = Card.new(:diamond, '2', 2)    
    @deck5 = Deck.new([@card17, @card18, @card21, @card24])    
    @deck6 = Deck.new([@card20, @card19, @card22, @card23])    
    @abe = Player.new("Abe", @deck5)    
    @bob = Player.new("Bob", @deck6)    
    @mad_turn = Turn.new(@abe, @bob)
  end

  describe '#new' do 
    it "exists" do 
      expect(@basic_turn).to be_an_instance_of Turn
    end

    it 'has attributes' do
      expect(@basic_turn.player1).to eq @megan
      expect(@basic_turn.player1.name).to eq 'Megan'
      expect(@basic_turn.player2).to eq @aurora
      expect(@basic_turn.player2.name).to eq 'Aurora'
      expect(@basic_turn.spoils_of_war).to eq []
    end
  end

  describe '#type' do
  # :basic
    it 'determines if the turn is basic' do
      expect(@megan.deck.cards[0].rank).to_not eq @aurora.deck.cards[0].rank
      expect(@basic_turn.type).to eq :basic
      expect(@basic_turn.winner).to eq @megan
    end
  # :war
    it 'determines if the turn is war' do
      expect(@sam.deck.cards[0].rank).to eq @dan.deck.cards[0].rank
      expect(@sam.deck.cards[2].rank).to_not eq @dan.deck.cards[2].rank
      expect(@war_turn.type).to eq :war
      expect(@war_turn.winner).to eq @dan
    end

  # :mutual_assured_destruction
    it 'determines if the turn is mutual assured destruction' do
      expect(@abe.deck.cards[0].rank).to eq @bob.deck.cards[0].rank
      expect(@abe.deck.cards[2].rank).to eq @bob.deck.cards[2].rank
      expect(@mad_turn.type).to eq :mutual_assured_destruction
      expect(@mad_turn.winner).to eq 'No Winner'
    end
  end

  describe '#is_basic?' do
  # :basic
    it "returns true if the ranking of each player's first card is different " do
      expect(@megan.deck.cards[0].rank).to_not eq @aurora.deck.cards[0].rank
      expect(@basic_turn.is_basic?).to be true
    end
  
  # :war & :mutual_assured_destruction
    it "returns false if the ranking of each player's first card is the same " do
      expect(@sam.deck.cards[0].rank).to eq @dan.deck.cards[0].rank
      expect(@war_turn.is_basic?).to be false
    end
  end

  describe '#begin_basic_outcome' do
  # :basic
    it "determines the winner by the higher ranking top card" do
      expect(@megan.deck.cards[0].rank).to_not eq @aurora.deck.cards[0].rank
      expect(@basic_turn.winner).to eq "No Winner"
      expect(@basic_turn.basic_turn_outcome).to eq :basic
      expect(@basic_turn.winner).to eq @megan
    end
  end

  describe '#war_turn_outcome' do
  # :war
    it "determines the winner by the higher ranking third card" do
      expect(@sam.deck.cards[0].rank).to eq @dan.deck.cards[0].rank
      expect(@war_turn.winner).to eq "No Winner"

      expect(@sam.deck.cards[2].rank).to_not eq @dan.deck.cards[2].rank
      expect(@war_turn.war_turn_outcome).to eq :war
      expect(@war_turn.winner).to eq @dan
    end
  end

  describe '#is_war?' do
  # :war
    it " determines if the result of the turn is war" do
      expect(@sam.deck.cards[0].rank).to eq @dan.deck.cards[0].rank
      expect(@war_turn.is_basic?).to be false

      expect(@sam.deck.cards[2].rank).to_not eq @dan.deck.cards[2].rank
      expect(@war_turn.is_war?).to be true
    end

    # test for if [0] rankings do not equal, but [2] rankings match.
  end

  describe '#determine_winner' do
  # :basic & :war
    it "determines the winner by comparing which player's card has the highest rank" do
      expect(@megan.deck.cards[0].rank).to eq 11
      expect(@aurora.deck.cards[0].rank).to eq 9
      expect(@basic_turn.determine_winner(0)).to eq @megan
    end
  end

  describe '#winner' do
  # :basic
    it "returns a string 'No Winner' if no rounds have been played" do
      expect(@megan.deck.cards[0].rank).to eq 11
      expect(@aurora.deck.cards[0].rank).to eq 9
      
      expect(@basic_turn.winner).to eq "No Winner"
    end

    it 'returns the instance of the player who won the round on a basic turn type' do
      expect(@basic_turn.winner).to eq "No Winner"
      expect(@megan.deck.cards[0].rank).to eq 11
      expect(@aurora.deck.cards[0].rank).to eq 9
      @basic_turn.type

      winner = @basic_turn.winner
      expect(winner).to eq @megan
    end

  # :war
    it 'returns the instance of the player who won the round on a war turn type' do
      expect(@basic_turn.winner).to eq "No Winner"
      expect(@sam.deck.cards[0].rank).to eq (@dan.deck.cards[0].rank)
      expect(@sam.deck.cards[2].rank).to_not eq (@dan.deck.cards[2].rank)
      @war_turn.type
      expect(@war_turn.winner).to eq @dan
    end

    
  # :mutual_assured_destruction
    it "returns a string 'No Winner' if the players' third card from the top have matching ranks" do
      expect(@basic_turn.winner).to eq "No Winner"
      expect(@abe.deck.cards[0].rank).to eq @bob.deck.cards[0].rank
      expect(@abe.deck.cards[2].rank).to eq @bob.deck.cards[2].rank

      @mad_turn.type
      expect(@mad_turn.winner).to eq "No Winner"
    end
  end

  describe '#pile_cards' do
  # :basic
    it 'each player will send the thier top card to the spoils pile if the turn type is :basic' do
      expect(@basic_turn.winner).to eq "No Winner"
      expect(@basic_turn.spoils_of_war).to eq []

      expect(@megan.deck.cards[0].rank).to eq 11
      expect(@aurora.deck.cards[0].rank).to eq 9

      @basic_turn.type

      @basic_turn.pile_cards

      expect(@basic_turn.spoils_of_war).to eq [@card1, @card3]
    end

  # :war
    it 'each player will send the thier top 3 cards to the spoils pile if the turn type is :war' do
      expect(@basic_turn.winner).to eq "No Winner"
      expect(@basic_turn.spoils_of_war).to eq []

      expect(@dan.deck.cards[0].rank).to eq 11
      expect(@sam.deck.cards[0].rank).to eq 11

      expect(@dan.deck.cards[2].rank).to eq 12
      expect(@sam.deck.cards[2].rank).to eq 8

      @war_turn.type
      @war_turn.pile_cards
    
      expect(@war_turn.spoils_of_war.size).to eq 6
    
      expect(@war_turn.spoils_of_war).to eq [ @card12, @card11, @card14, @card9, @card10, @card13 ]
    end

  # :mutual_assured_destruction
    it 'each player will send the thier top 3 cards to the trash pile if the turn type is :mutual_assured_destruction' do
      expect(@abe.deck.cards[0].rank).to eq 11
      expect(@bob.deck.cards[0].rank).to eq 11

      expect(@abe.deck.cards[2].rank).to eq 8
      expect(@bob.deck.cards[2].rank).to eq 8
      
      expect(@abe.deck.cards.size).to eq 4
      expect(@bob.deck.cards.size).to eq 4

      expect(@mad_turn.type).to eq :mutual_assured_destruction 

      @mad_turn.pile_cards

      expect(@mad_turn.spoils_of_war).to eq []
      @deck5.cards.shift(3)
      @deck6.cards.shift(3)
      expect(@abe.deck).to eq @deck5
      expect(@bob.deck).to eq @deck6
    end
  end

  describe '#push_cards_to_spoils' do
  # :basic
    it "removes 1 card from each player and adds them to the spoils with turn type :basic" do
      expect(@megan.deck.cards[0]).to eq @card1
      expect(@aurora.deck.cards[0]).to eq @card3
      expect(@basic_turn.spoils_of_war).to eq []

      @basic_turn.type
      @basic_turn.push_cards_to_spoils(:basic)
      expect(@megan.deck.cards[0]).to eq @card2
      expect(@aurora.deck.cards[0]).to eq @card4
      expect(@basic_turn.spoils_of_war).to eq [@card1, @card3]
    end

  # :war
    it "removes 3 cards from each player and adds them to the spoils with turn type :war" do
      expect(@sam.deck.cards[0..2]).to eq [ @card9, @card10, @card13 ]
      expect(@dan.deck.cards[0..2]).to eq [ @card12, @card11, @card14 ]
      expect(@war_turn.spoils_of_war).to eq []

      @war_turn.type
      @war_turn.push_cards_to_spoils(:war)
      expect(@sam.deck.cards[0]).to eq @card16
      expect(@dan.deck.cards[0]).to eq @card15
    
      expect(@war_turn.spoils_of_war).to eq [ @card12, @card11, @card14, @card9, @card10, @card13 ]
    end
  end

  describe '#spoil_calculation' do
  # :basic
    it "calculates one card to be removed for each player if turn type is :basic" do 
      expect(@basic_turn.spoil_calculation(:basic)).to eq 1
    end

  # :war
    it "calculates 3 cards to be removed for each player if turn type is :war" do 
      expect(@war_turn.spoil_calculation(:war)).to eq 3
    end
  end

  describe '#award_spoils' do
  # :basic
    it "basic: moves the cards from the spoils of war pile into the winning player's hand" do
      expect(@megan.deck.cards.size).to eq 4
      expect(@aurora.deck.cards.size).to eq 4
      expect(@basic_turn.spoils_of_war).to eq []
      expect(@basic_turn.type).to eq :basic

      @basic_turn.pile_cards
      expect(@megan.deck.cards.size).to eq 3
      expect(@aurora.deck.cards.size).to eq 3
      expect(@basic_turn.spoils_of_war).to eq [@card1, @card3]
      expect(@megan).to eq @basic_turn.winner
      @basic_turn.award_spoils(@megan)
      expect(@megan.deck.cards.size).to eq 5
      expect(@aurora.deck.cards.size).to eq 3

      expect(@megan.deck.cards).to eq [@card2, @card5, @card8, @card1, @card3]
      expect(@aurora.deck.cards).to eq [@card4, @card6, @card7]
      expect(@megan.deck.cards.size).to eq 5
      expect(@aurora.deck.cards.size).to eq 3
      expect(@basic_turn.spoils_of_war).to eq []
    end

  # :war
    it "war: moves the cards from the spoils of war pile into the winning player's hand" do
      expect(@sam.deck.cards.size).to eq 4
      expect(@dan.deck.cards.size).to eq 4
      expect(@sam.deck.cards).to eq [ @card9, @card10, @card13, @card16 ]
      expect(@dan.deck.cards).to eq [ @card12, @card11, @card14, @card15 ]
      expect(@war_turn.spoils_of_war).to eq []
      expect(@war_turn.type).to eq :war

      @war_turn.pile_cards

      expect(@sam.deck.cards.size).to eq 1
      expect(@dan.deck.cards.size).to eq 1
      expect(@sam.deck.cards).to eq [ @card16 ]
      expect(@dan.deck.cards).to eq [ @card15 ]
      expect(@war_turn.spoils_of_war).to eq [ @card12, @card11, @card14, @card9, @card10, @card13 ]
      expect(@dan).to eq @war_turn.winner

      @war_turn.award_spoils(@dan)

      expect(@dan.deck.cards.size).to eq 7
      expect(@sam.deck.cards.size).to eq 1
      expect(@dan.deck.cards).to eq [ @card15, @card12, @card11, @card14, @card9, @card10, @card13 ]
      expect(@sam.deck.cards).to eq [ @card16 ]
      expect(@war_turn.spoils_of_war).to eq []
    end

  # :mutual_assured_destruction
    it "awards no spoils if it is mutual assured destruction" do 
      expect(@mad_turn.spoils_of_war).to eq []

      expect(@abe.deck.cards).to eq [ @card17, @card18, @card21, @card24 ]
      expect(@bob.deck.cards).to eq [ @card20, @card19, @card22, @card23 ]
      
      expect(@mad_turn.type).to eq :mutual_assured_destruction
      winner = @mad_turn.winner

      expect(@mad_turn.award_spoils(winner)).to eq "No Winner"

      expect(@mad_turn.spoils_of_war).to eq []

      expect(@abe.deck.cards).to eq [ @card17, @card18, @card21, @card24 ]
      expect(@bob.deck.cards).to eq [ @card20, @card19, @card22, @card23 ]
    end
  end

  describe '#push_cards_to_trash' do
  # :mutual_assured_destruction
    it "removes each of the player's top three cards" do
      expect(@abe.deck.cards).to eq [ @card17, @card18, @card21, @card24 ]
      expect(@bob.deck.cards).to eq [ @card20, @card19, @card22, @card23 ]
      
      @mad_turn.push_cards_to_trash

      expect(@abe.deck.cards).to eq [@card24]
      expect(@bob.deck.cards).to eq [@card23]
    end
  end
end