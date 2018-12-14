class Hand
  MAX_SIZE = 3
  MAX_POINTS = 21

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def points
    card_points = cards.map(&:point).sum
    return card_points unless card_points > MAX_POINTS
    ace_correction(card_points)
    cards.map(&:point).sum
  end

  private

  def ace_correction(current_points)
    correction = Card::ACE_MAX_VALUE - Card::ACE_MIN_VALUE
    corrected_value = current_points
    cards.each do |card|
      if card.ace? && corrected_value > MAX_POINTS
        card.point = Card::ACE_MIN_VALUE
        corrected_value -= correction
      end
    end
  end
end
