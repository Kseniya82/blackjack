require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'bank'
require_relative 'interface'

class Game
  INITIAL_CASH = 100
  USER_MENU = [
    { handler: :player_pass_course, title: 'Пропустить ход' },
    { handler: :player_give_card, title: 'Взять карту' },
    { handler: :player_open_cards, title: 'Открыть карты' }
  ].freeze

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
      set_default_state
      init_deal
      give_money if bank_empty?
      rely
      @interface.show_cash(@player, @dealer)
      game_party
      result
      break unless new_game?
    end
  end

  def set_default_state
    @player_open_cards = false
    @player.fold_cards
    @dealer.fold_cards
  end

  def init_deal
    2.times do
      @player.take_card(@deck)
      @dealer.take_card(@deck)
    end
  end

  def give_money
    @player.cash = INITIAL_CASH
    @dealer.cash = INITIAL_CASH
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
    @interface.show_menu(USER_MENU)
    choice = @interface.receive_choice
    selected_item = USER_MENU[choice - 1]
    send(selected_item[:handler]) if selected_item
  end

  def player_pass_course
    @interface.show_pass_course(@player)
  end

  def player_give_card
    unless @player.max_cards?
      @player.take_card(@deck)
      @interface.show_give_card(@player)
    end
  end

  def player_open_cards
    @player_open_cards = true
    open_cards
  end

  def dealer_course
    if @dealer.will_take_card? && !@dealer.max_cards?
      @dealer.take_card(@deck)
      @interface.show_give_card(@dealer)
    else
      dealer_pass_course
    end
  end

  def dealer_pass_course
    @interface.show_pass_course(@dealer)
  end

  def result
    show_winner_by_bank if bank_empty?
    return if bank_empty?

    open_cards unless @player_open_cards
    if @winner
      @bank.give_bank(@winner)
    else
      @bank.refund(@player, @dealer)
    end
    @interface.show_cash(@player, @dealer)
  end

  def rely
    @bank.rely(@player, @dealer) unless bank_empty?
  end

  def bank_empty?
    @player.cash < Bank::BET_SIZE || @dealer.cash < Bank::BET_SIZE
  end

  def show_winner_by_bank
    if winner_by_bank
      @interface.show_winner(winner_by_bank)
    else
      @interface.show_draw
    end
  end

  def winner_by_bank
    if @player.cash > @dealer.cash && @player.cash > Bank::BET_SIZE
      @player
    elsif @dealer.cash > @player.cash && @dealer.cash > Bank::BET_SIZE
      @dealer
    end
  end

  def open_cards?
    @player.max_cards? && @dealer.max_cards? || @player_open_cards
  end

  def open_cards
    @interface.show_open_cards(@player, @dealer)
    @winner = define_winner
    if @winner
      @interface.show_winner(@winner)
    else
      @interface.show_draw
    end
  end

  def new_game?
    @interface.ask_new_game
    choice = @interface.receive_choice
    choice == 1
  end

  def define_winner
    return if @dealer.points > Hand::MAX_POINTS && @player.points > Hand::MAX_POINTS
    return if @dealer.points == @player.points
    return @player if @dealer.points > Hand::MAX_POINTS
    return @dealer if @player.points > Hand::MAX_POINTS
    [@player, @dealer].max_by(&:points)
  end
end
