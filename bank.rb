class Bank
  BET_SIZE = 10

  def initialize
    @bank = 0
  end

  def rely(user, dealer)
    user.cash -= BET_SIZE
    dealer.cash -= BET_SIZE
    @bank += BET_SIZE * 2
  end

  def give_bank(winner)
    winner.cash += @bank
    @bank = 0
  end

  def refund(user, dealer)
    user.cash += @bank / 2
    dealer.cash += @bank / 2
    @bank = 0
  end
end
