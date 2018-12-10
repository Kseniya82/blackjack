class Bank
  def initialize
    @bank = 0
  end

  def rely
    user.cash -= 10
    dealeer.cash -= 10
    @bank +=20
  end

  def give_bank(winner)
    if winner
      winner.cash += @Bank
    else
      user,cash += @bank / 2
      dealer.cash += @bank / 2
    end
  end
end
    
