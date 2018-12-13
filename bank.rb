class Bank
  def initialize
    @bank = 0
  end

  def rely (user, dealer)
    user.cash -= 10
    dealer.cash -= 10
    @bank += 20
  end

  def give_bank(winner,user,dealer)
    if winner
      winner.cash += @bank
      @bank = 0
    else
      user.cash += @bank / 2
      dealer.cash += @bank / 2
      @banl = 0
    end
  end
end
