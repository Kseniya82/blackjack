class Hand
  MAX_SIZE = 3
  MAX_POINTS = 21
  
  attr_accessor :cards

  def points
    @points = []
    cards.each { |card| @points << card.point }
  end

  def counting_points
    points
    change_ace_point if @points.sum > MAX_POINTS
    @points.sum
  end

  def change_ace_point
    cards.each do |card|
      points
      card.point = 1 if card.rank == 'A' && @points.sum >MAX_POINTS
    end
  end
end
