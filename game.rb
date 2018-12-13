require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'bank'
require_relative 'interface'
class Game
  attr_reader :player, :dealer, :deck

  def initialize
    @interface = Interface.new
    @dealer = Dealer.new
    @bank = Bank.new
  end

  def run
    create_player
    give_money
    new_game
  end

  private

  def create_player
    @interface.ask_name
    name = @interface.receive_name
    @player = Player.new(name)
  end

  def new_game
    loop do
      @deck = Deck.new
      @deck.mix_deck
      @deck.distribute_cards(@player, @dealer)
      rely
      @player_open_cards = false
      game_party
      result
      break unless new_game?

      give_money if bank_empty?
    end
  end

  def give_money
    @player.cash = 100
    @dealer.cash = 100
  end

  def game_party
    loop do
      break if bank_empty?

      @interface.show_cards(@player, @dealer)
      player_course
      break if @player_open_cards

      dealer_course
      break if open_cards?
    end
  end

  def player_course
    @interface.show_menu
    choice = @interface.receive_choice
    selected_item = Interface::USER_MENU[choice - 1]
    send(selected_item[:handler]) if selected_item
  end

  def player_pass_course
    @interface.show_pass_course(@player)
  end

  def player_give_card
    if @player.hand.cards.size < 3
      @player.take_card(@deck)
      @interface.show_give_card(@player)
    end
  end

  def player_open_cards
    @player_open_cards = true
    open_cards
  end

  def dealer_course
    if @dealer.points < 17 && @dealer.hand.cards.size < 3
      @dealer.take_card(@deck)
      @interface.show_give_card(@dealer)
    else
      dealer_pass_course
    end
  end

  def dealer_pass_course
    @interface.show_pass_course(@dealer)
    player_course
  end

  def result
    show_winner_by_bank if bank_empty?
    return if bank_empty?

    open_cards unless @player_open_cards
    @bank.give_bank(winner, @player, @dealer)
  end

  def rely
    @bank.rely(@player, @dealer) unless bank_empty?
  end

  def bank_empty?
    if @player.cash < 10 || @dealer.cash < 10
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
    if @player.cash > @dealer.cash && @player.cash > 10
      @player
    elsif @dealer.cash > @player.cash && @dealer.cash > 10
      @dealer
    end
  end

  def open_cards?
    if @player.hand.cards.size >= 3 && dealer.hand.cards.size >= 3 || @player_open_cards
      true
    else
      false
    end
  end

  def open_cards
    @interface.show_open_cards(@player, @dealer)
    if winner
      @interface.show_winner(winner)
    else
      @interface.show_draw
    end
  end

  def new_game?
    @interface.ask_new_game
    choice = @interface.receive_choice
    choice == 1
  end

  def winner
    if (@player.points > @dealer.points || @dealer.points >= 21) && @player.points < 21
      @player
    elsif (@dealer.points > @player.points || @player.points >= 21) && @dealer.points < 21
      @dealer
    end
  end
end
