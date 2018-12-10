class Deck
  CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SIUTS = %w[♠ ♥ ♣ ♦].freeze
  POINTS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze
  def initialize
    @deck = {}
    index = 0
    count = 0
    CARDS.product(SIUTS).each do |card|
      @deck[card.join] = POINTS[index]
      count += 1
      index = count / 4
    end
  end

  def mix_deck
    @play_deck = @deck.to_a.shuffle!.to_h
  end

  def distribute_cards
    user.cards = @play_deck.first(2).to_h
    @play_deck.shift.shift
    dealer.cards = @play_deck.first(2).to_h
    @play_deck.shift.shift
  end

  def give_card(player)
    player.cards << @play_deck.first.to_h
    @play_deck.shift
  end
end
