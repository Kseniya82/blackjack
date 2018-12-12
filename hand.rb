class Hand
  attr_accessor :cards

  def points
    @points = []
    cards.each { |card| @points << card.point }
  end

  def counting_points
    points
    change_ace_point if @points.sum > 21
    @points.sum
  end

  def change_ace_point
    cards.each do |card|
      if card.rank == 'A'
        card.point = 1
        counting_points
      end
    end
  end
end
