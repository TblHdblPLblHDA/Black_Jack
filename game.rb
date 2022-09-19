class Game
    attr_accessor :player, :dealer, :deck, :round_bank
  
    def initialize
      @dealer = Dealer.new
      @deck = Deck.new
      @round_bank = 0
      @skip = false
    end
  
    def start_game
      puts 'Your na,e: '
      player_name = gets.chomp
      @player = Player.new(player_name)
  
      loop do
        check_balance
        deal_cards(player)
        deal_cards(dealer)
  
        puts 'bid mane $10'
  
        player.place_bet
        dealer.place_bet
  
        show_balance
  
        print 'giving (you | dealer): '
        player.show_hand
        print '| '
        dealer.show_hidden
        puts ' '
  
        make_choice
        winner
        break unless another_round?
  
        prepare_new_round
      end
    end
  
    def deal_cards(player)
      case player.hand.size
      when 0
        player.hand = 2.times.map { deck.cards.pop }
        player.count_points
      when 2
        player.hand << deck.cards.pop
        player.count_points
      when 3
        'You have 3 cards, no more. Opening it?'
      end
    end
  
    def show_balance
      puts "Your balance #{@player.bank} | dealer balance #{@dealer.bank}"
      @round_bank = @player.bet + @dealer.bet
      puts "In bank now #{@round_bank}"
    end
  
    def make_choice
      @skip = false
      puts ' '
      puts 'Your turn: '
      puts '1. pass'
      puts '2. take card'
      puts '3. open cards'
      print '>>'
  
      choice = gets.to_i
  
      case choice
      when 1
        @skip = true
        dealer_turn
      when 2
        deal_cards(player)
        return if player.busted?
  
        dealer_turn
      when 3
        open_cards
      end
    end
  
    def dealer_turn
      points = dealer.points
  
      if points >= 17
        puts 'Dealer gonna make a move'
        player_turn if @skip
      elsif points < 17
        puts 'Dealer take a card'
        deal_cards(dealer)
        return if dealer.busted?
  
        player_turn if @skip
        open_cards
      end
    end
  
    def player_turn
      puts ' '
      puts 'Your turn: '
      puts '1. pass'
      puts '2. open cards'
      print '>'
  
      choice = gets.to_i
  
      case choice
      when 1
        deal_cards(player)
        return if player.busted?
  
        open_cards
      when 2
        open_cards
      end
    end
  
    def open_cards
      player.show_hand
      print "You have #{@player.points} points"
      puts ' '
      dealer.show_hand
      print " Dealer has #{dealer.points}"
    end
  
    def winner
      puts ' '
  
      if player.busted?
        player.show_hand
        puts ' '
        @dealer.bank += round_bank
        puts 'You have too much. Dealer is win'
        puts "Your balance: #{player.bank}"
        return
      elsif dealer.busted?
        dealer.show_hand
        puts ' '
        @player.bank += round_bank
        puts 'Dealer has too much. You are win!'
        puts "Your balance: #{player.bank}"
        return
      end
  
      if player.points > dealer.points
        puts 'You are win. Take all bank'
        @player.bank += round_bank
        puts "Your balance: #{player.bank}"
      elsif player.points < dealer.points
        puts 'Dealer is win. He take all bank'
        @dealer.bank += round_bank
        puts "Your balance: #{player.bank}"
      elsif player.points == dealer.points
        puts 'Draw. The bets are divided equally'
        @player.bank += round_bank/2
        @dealer.bank += round_bank/2
        puts "Your bank: #{player.bank}"
      end
    end
  
    def black_jack?(sum)
      sum == 21
    end
  
    def another_round?
      puts ' '
      print 'One more round? [Y/N]: '
      choice = gets.chomp.upcase
  
      case choice
      when 'Y'
        true
      when 'N'
        false
      end
    end
  
    def prepare_new_round
      @player.hand = []
      @dealer.hand = []
      @deck = Deck.new
    end
  
    def check_balance
      if @player.bank <= 0
        puts 'You dont have money. Game is end.'
        exit
      elsif @dealer.bank <= 0
        puts 'Dealer dont has money. Game is end'
        exit
      end
    end
  end
  