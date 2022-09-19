class Dealer < Player
    def initialize
      super('Dealer')
    end
  
    def show_hidden
      @hand.size.times {print '*'}
    end
  end
  