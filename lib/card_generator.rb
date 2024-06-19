class CardGenerator 

  def initialize(file)
    @file = File.read(file)
    @cards_info = @file.split("\n")
  end

  def cards
    cards = []
    lines = @cards_info.each do |card_info|
      card_info.split(",")
    end
    lines.each do |card_data|
      data = card_data.split(",")
      value = data[0]
      suit = data[1].strip
      rank = data[2].to_i
      cards << Card.new(suit, value, rank)
    end
    cards
  end
end