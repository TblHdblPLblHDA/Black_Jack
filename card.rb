class Card
    attr_reader :suite, :rank, :value
  
    SUITS = {
      spade: "\u2660",
      heart: "\u2665",
      diamond: "\u2666",
      club: "\u2663"
    }.freeze
  
    VALUES = {
      2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10,
      'j' => 10, 'q' => 10, 'k' => 10, 'a' => 11
    }.freeze
  
    def initialize(suite, rank)
      @suite = get_suite(suite)
      @rank = rank
      @value = get_value(rank)
    end
  
    def show
      "#{@rank}#{@suite}"
    end
  
    protected
  
    def get_value(rank)
      VALUES[rank]
    end
  
    def get_suite(suite)
      SUITS[suite]
    end
  end
  