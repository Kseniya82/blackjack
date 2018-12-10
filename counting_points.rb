require_relative 'user'
require_relative 'dealer'

module CountingPoints
  attr_reader :winner

  def counting_points(cards)
    if cards.values.sum > 21
      cards.each do |key|
        cards[key] = 1 if key.include?('A')
      end
    end
    cards.values.sum
  end

  def winner
    user.points = counting_points(user.cards)
    dealer.points = counting_points(dealer.cards)
    winner = if user.points > dealer.points && user.points < 21
               user
             elsif user.points < dealer.points && dealer.points < 21
               dealer
             end
  end
end
