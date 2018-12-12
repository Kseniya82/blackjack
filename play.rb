require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'
require_relative 'user_menu'
require_relative 'dealer_logics'
require_relative 'messages'
class Play
  include UserMenu
  include DealerLogics
  include Messages

  attr_reader :user, :dealer

  def create_user
    puts 'Вееедите Ваше имя'
    name = gets.chomp
    @user = User.new(name)
  end

  def create_dealer
    @dealer = Dealer.new
  end

  def create_hand
    @hand1 = Hand.new
    @user.hand = @hand1
    @hand2 = Hand.new
    @dealer.hand = @hand2
  end

  def new_game
    @user.cash = 100
    @dealer.cash = 100
    @user_open_cards = false
    loop do
      @deck = Deck.new
      @deck.mix_deck
      @deck.distribute_cards(@hand1, @hand2)
      game_party
      break unless new_game?
    end
  end

  def game_party
    loop do
      show_cards
      user_course
      break if @user_open_cards

      dealer_course
      break if open_cards?
    end
    open_cards unless @user_open_cards
  end

  def open_cards?
    if @hand1.cards.size >= 3 && @hand2.cards.size >= 3 || @user_open_cards
      true
    else
      false
    end
  end

  def winner
    user_points = @hand1.counting_points
    dealer_points = @hand2.counting_points
    @winner =
      if user_points > dealer_points || dealer_points >= 21 && user_points < 21
        @user
      elsif dealer_points > user_points || user_points >= 21 && dealer_points < 21
        @dealer
      end
    puts @winner.class
  end
end
