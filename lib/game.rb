require "./lib/card_generator"

class Game
  attr_reader :cards,
              :player1_deck,
              :player2_deck,
              :player1,
              :player2

  def initialize
    @cards = CardGenerator.new("cards.txt").cards
    @player1_deck = []
    @player2_deck = []
    @player1 = nil
    @player2 = nil
  end

  def shuffle_cards
    @cards.shuffle!
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
    @player1 = Player.new("Brittney", @player1_deck)
    @player2 = Player.new("Kristin", @player2_deck)
  end

  def self.set_up
    game = Game.new
    game.shuffle_cards
    game.make_computer_players
    game.greeting
  end

  def greeting
    puts greeting_message
    begin_game_response_check
  end

  def begin_game_response_check
    response = gets.chomp
    if response.downcase == "go" || response == "g"
      start
    elsif response.downcase == "quit" || response == "q"
      exit
    else
      puts "Please enter 'g', 'go', 'Go', or 'GO' if you would still like to play this game.\nIf you would like to exit, please enter 'QUIT', 'quit', or 'q'."
      begin_game_response_check
    end
  end

  def greeting_message
  "  Welcome to War! (or Peace) This game will be played with 52 cards.
  The players today are #{@player1.name} and #{@player2.name}.
  Type 'GO' to start the game!
  ------------------------------------------------------------------"
  end

  def start
    counter = 1
    until @player1.has_lost? || @player2.has_lost? do
      return draw if counter > 1000000
      turn = Turn.new(@player1, @player2)
      type = turn.type
      winner = turn.winner
      turn.pile_cards
      if type == :basic
        puts "Turn #{counter}: #{winner.name} won two cards"
      elsif type == :war
        puts "Turn #{counter}: WAR - #{winner.name} won #{turn.spoils_of_war.size} cards"
      elsif type == :mutual_assured_destruction
        puts "Turn #{counter}: *mutually assured destruction* - 6 cards removed from play"
      end
      turn.award_spoils(winner)
      counter += 1
    end
    puts "*~*~*~* #{winner.name} has won the game! *~*~*~*"
  end

  def draw
    puts "---- DRAW ----"
  end
end
