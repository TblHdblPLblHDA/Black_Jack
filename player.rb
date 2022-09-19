class Player
    attr_accessor :points, :name, :hand, :bank

    START_BANK = 100
    BET = 10

    def initiliaze(name)
        @name = name
        bank = @START_BANK
        @points = 0
        hand = []
    end

    def get_card(card)
        @hand << card
        @score += card_value(card, @score)
    end
    
    def card_value(card, local_score)
       if card.name == 'Ace' && local_score >= 11
          1
       else
          card.value
        end
    end
    
    def show_cards_in_hand
      local_score = 0
      @hand.each do |card|
        card.card_info(local_score)
        local_score += card_value(card, local_score)
      end
    end
end
