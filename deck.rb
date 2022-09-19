require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    make_deck
    shuffle
  end

  def make_deck
    (2..10).each do |rank|
      %i[spade diamond club heart].each do |suit|
        @cards << Card.new(suit, rank)
      end
    end

    %w[j q k a].each do |rank|
      %i[spade diamond club heart].each do |suit|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
    cards.shuffle!
  end
end
