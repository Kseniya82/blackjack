class User

  def initialize(name)
    @name = name.capitalize!
    @cash = 100
    @cards = []
  end

end
