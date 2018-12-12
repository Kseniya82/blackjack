require_relative 'user_menu'
class User
  include UserMenu
  attr_accessor :hand, :cash
  attr_reader :name
  def initialize(name)
    @name = name
    @name.capitalize!
  end
end
