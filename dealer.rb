require_relative 'player'

class Dealer < Player
  SCORE_LIMIT = 17
  
  def initialize(name = 'dealer')
    super
  end

  def will_take_card?
    points < SCORE_LIMIT
  end
end
