require_relative 'card'
require_relative 'hand'

class Deck
  def initialize
    @deck = create_deck
    mix_deck
  end

  def deal_card
    @deck.shift
  end

  private

  def create_deck
    deck = []
    Card::RANK.each do |rank|
      Card::SIUTS.each do |siut|
        deck << Card.new(rank, siut)
      end
    end
    deck
  end

  def mix_deck
    @deck.shuffle!
  end

end
