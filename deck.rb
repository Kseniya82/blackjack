class Deck

  CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  SIUTS = %w[♠ ♥ ♣ ♦]

  def initialize
    @deck = []
    CARDS.product(SIUTS).each { |card| @deck << card.join}
  end

  def mix_deck
    @play_deck = @deck.shuffle!
  end

  def distribute_cards
    user.cards = @play_deck.first(2)
    @play_deck = @play_deck.drop(2)
    dealer.cards = @play_deck.first(2)
    @play_deck = @play_deck.drop(2)
  end

  def give_card(player)
    player.cards << @play_deck.first
    @play_deck = @play_deck.drop(1)
  end

end
