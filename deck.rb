require_relative 'card'
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

  def distribute_cards(user, dealer)
    user.cards = @play_deck.first(2)
    @play_deck = @play_deck.drop(2)
    dealer.cards = @play_deck.first(2)
    @play_deck = @play_deck.drop(2)
  end

  def give_card(player)
    player.cards << @play_deck.first.to_h
    @play_deck.drop(1)
  end
end
