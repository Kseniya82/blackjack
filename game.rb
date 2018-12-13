require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'
require_relative 'bank'
require_relative 'interface'
class Game

  attr_reader :user, :dealer, :winner

  def initialize
    @interface = Interface.new
    @dealer = Dealer.new
    @hand1 = Hand.new
    @hand2 = Hand.new
    @dealer.hand = @hand2
    @bank = Bank.new
    @deck = Deck.new
  end

  def run
    create_user
    give_money
    new_game
  end

  private

  def create_user
    @interface.ask_name
    name = @interface.receive_name
    @user = User.new(name)
    @user.hand = @hand1
  end

  def new_game
    loop do
      @deck.mix_deck
      @deck.distribute_cards(@hand1, @hand2)
      rely
      game_party
      result
      break unless new_game?
      give_money if bank_empty?
    end
  end

  def give_money
    @user.cash = 100
    @dealer.cash = 100
    @user_open_cards = false
  end

  def game_party
    loop do
      break if bank_empty?
      @interface.show_cards(@hand1, @hand2)
      user_course
      break if @user_open_cards

      dealer_course
      break if open_cards?
    end
  end

  def user_course
    @interface.show_menu
    choice = @interface.receive_choice
    selected_item = Interface::USER_MENU[choice - 1]
    send(selected_item[:handler]) if selected_item
  end

  def user_pass_course
    @interface.show_pass_course(@user)
    dealer_course
  end

  def user_give_card
    if @user.hand.cards.size < 3
      @deck.give_card(@user.hand)
      @interface.show_give_card(@user)
    end
  end

  def user_open_cards
    @user_open_cards = true
    open_cards
  end

  def dealer_course
    if @hand2.counting_points < 17 && @hand2.cards.size < 3
      @deck.give_card(@hand2)
      @interface.show_give_card(@dealer)
    else
      dealer_pass_course
    end
  end

  def dealer_pass_course
    @interface.show_pass_course(@dealer)
    user_course
  end

  def result
    show_winner_by_bank if bank_empty?
    return if bank_empty?
    open_cards unless @user_open_cards
    @bank.give_bank(winner, @user, @dealer)
  end

  def rely
    @bank.rely(@user, @dealer) unless benk_empty?
  end

  def bank_empty?
    if @user.cash < 10 || @dealer.cash < 10
      true
    else
      false
    end
  end

  def show_winner_by_bank
    if winner_by_bank
      @interface.show_winner(winner_by_bank)
    else
      @interface.show_draw
    end
  end

  def winner_by_bank
    if @user.cash > @dealer.cash && @user.cash > 10
      @user
    elsif @dealer.cash > @user.cash && @dealer.cash > 10
      @dealer
    end
  end

  def open_cards?
    if @hand1.cards.size >= 3 && @hand2.cards.size >= 3 || @@user_open_cards
      true
    else
      false
    end
  end

  def open_cards
    @interface.show_open_cards(@hand1, @hand2)
    if winner
      @interface.show_winner(winner)
    else
      @interface.show_draw
    end
  end

  def new_game?
    @interface.ask_new_game
    choice = @interface.receive_choice
    if choice == 1
      true
    else
      false
    end
  end

  def winner
    user_points = @hand1.counting_points
    dealer_points = @hand2.counting_points
      if (user_points > dealer_points || dealer_points >= 21) && user_points < 21
        @user
      elsif (dealer_points > user_points || user_points >= 21) && dealer_points < 21
        @dealer
      end
  end
end
