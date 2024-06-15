class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize (player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @winner = nil
    @loser = nil
  end

  def type
    if is_basic?
      basic_turn_outcome
    elsif is_war?
      war_turn_outcome
    else
      @winner = nil
      @turn_type = :mutual_assured_destruction
    end
  end

  def is_basic?
    @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
  end

  def basic_turn_outcome
    determine_winner(0)
      @turn_type = :basic
  end

  def war_turn_outcome
    determine_winner(2)
      @turn_type = :war
  end

  def is_war?
    @player1.deck.rank_of_card_at(2) != @player2.deck.rank_of_card_at(2)
  end

  def determine_winner(i)
    if @player1.deck.rank_of_card_at(i) > @player2.deck.rank_of_card_at(i)
      @loser = @player2
      @winner = @player1
    else
      @loser = @player1
      @winner = @player2
    end
  end

  def winner
    @winner.nil? ? "No Winner" : @winner
  end

  def pile_cards
    if @turn_type == :mutual_assured_destruction
      push_cards_to_trash
    else
      push_cards_to_spoils(@turn_type)
    end
  end

  def push_cards_to_spoils(decision)

    # require 'pry'; binding.pry
    spoil_calculation(decision)
    p1_spoils = @winner.deck.cards.shift(@spoil_n)
    p2_spoils = @loser.deck.cards.shift(@spoil_n)
    p1_spoils.concat(p2_spoils)
    @spoils_of_war.concat(p1_spoils)
  end

  def spoil_calculation(decision)
    if decision == :basic
      @spoil_n = 1
    elsif decision == :war 
      @spoil_n = 3
    end
  end

  def award_spoils(winner)
    spoils = @spoils_of_war
    @spoils_of_war = []
    winner.deck.cards.concat(spoils)
  end

  def push_cards_to_trash
    players = [ @player1, @player2]
    players.each do |player|
      3.times do 
        player.deck.remove_card  
      end
    end
  end
end
