class Player
  attr_accessor :points, :bank, :hand, :name

  START_BANK = 100
  BET = 10

  def initialize(name)
    @name = name
    @points = 0
    @bank = START_BANK
    @hand = []
  end

  def show_hand
    hand.each do |card|
      print "#{card.rank}#{card.suite} "
    end
  end

  def place_bet
    @bank -= BET
  end

  def count_points
    @points = 0
    @ace_sum = 0
    @ace_counts = 0

    @hand.each do |card|
      if ace?(card)
        @ace_counts += 1
        @ace_sum += 11
      end
      @points += card.value
    end
    @points = @points - @ace_sum + @ace_counts if busted?
  end

  def bet
    BET
  end

  def busted?
    @points > 21
  end

  def ace?(card)
    card.rank == 'a'
  end
end