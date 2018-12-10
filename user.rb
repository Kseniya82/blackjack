class User
  def initialize(name)
    @name = name.capitalize!
    @cash = 100
    @cards = []
    @points = 0
  end
end
