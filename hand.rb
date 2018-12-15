class Hand
  MAX_SIZE = 3
  MAX_POINTS = 21

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def points
    ace_correction if cards.find(&:ace?)
    cards.map(&:point).sum
  end

  private

  def ace_correction
    return unless cards.map(&:point).sum > MAX_POINTS
    cards.select(&:ace?).each do |card|
      if cards.map(&:point).sum > MAX_POINTS
        card.point = Card::ACE_MIN_VALUE
      end
    end
  end
end
