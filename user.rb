require_relative 'user_menu'
class User
  include UserMenu

  attr_accessor :cards

  def initialize(name)
    @name = name.capitalize!
    @cash = 100
    @cards = []
  end
end
