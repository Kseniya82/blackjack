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
    @play_deck = @deck.shuffle!
  end

  def distribute_cards(hand1, hand2)
    hand1.cards = @play_deck.first(2)
    @play_deck = @play_deck.drop(2)
    hand2.cards = @play_deck.first(2)
    @play_deck = @play_deck.drop(2)
  end

  def give_card(hand)
    hand.cards << @play_deck.first
    @play_deck.drop(1)
  end
end
