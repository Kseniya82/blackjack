require_relative 'card'
require_relative 'hand'
class Deck
  def initialize
    @deck = []
    Card::RANK.each do |rank|
      Card::SIUTS.each do |siut|
        @deck << Card.new(rank, siut)
      end
    end
  end

  def mix_deck
    @deck.shuffle!
  end

  def distribute_cards(player, dealer)
    player.hand.cards = @deck.shift(2)
    dealer.hand.cards = @deck.shift(2)
  end

  def deal_card
    @deck.shift
  end
end
