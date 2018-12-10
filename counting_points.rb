module CountingPoints

  def counting_points(cards)
    sum = 0
    cards.each do |card|
      if card.to_i > 0
        sum += card.to_i
      elsif !card.include?("A")
        sum += 10
      elsif sum + 11 < 21
        sum += 11
      else
        sum += 1
      end
    end
  end

  def winner
    user.points = counting_points(user.cards)
    dealer.points = counting_points(dealer.cards)
    if user.points > dealer.points && user.points < 21
      winner = user
    elsif user.points < dealer.points && dealer.points < 21
      winner = dealer
    else
      winner = nil
    end
  end
end
