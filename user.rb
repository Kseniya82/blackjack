class User
  attr_accessor :hand, :cash
  attr_reader :name
  def initialize(name)
    @name = name
    @name.capitalize!
  end
end
