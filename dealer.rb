class Dealer
  attr_accessor :cards

  def initialize
    @cash = 100
    @cards = []
  end

  def dealer_course
    if counting_points(dealer.cards) < 17 && dealer.cards.size < 3
      give_card(self)
    else
      pass_course
    end
  end

  def pass_course
    show_pass_course(self)
    user_course
  end
end
