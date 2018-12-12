class Card
  RANK = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SIUTS = %w[♠ ♥ ♣ ♦].freeze
  POINTS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze

  attr_reader :rank, :siute
  attr_accessor :point

  def initialize(rank, siute)
    @rank = rank
    @siute = siute
    @point = POINTS[RANK.index(rank)]
  end
end
