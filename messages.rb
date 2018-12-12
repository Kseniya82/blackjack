module Messages
  def show_pass_course(player)
    puts "#{player.class} пропускает ход"
  end

  def show_cards
    puts 'Кврты игрока'
    @hand1.cards.each { |card| print "#{card.rank + card.siute} " }
    puts "Кол-во очков #{@hand1.counting_points}"
    puts 'Карты дилера'
    @hand2.cards.each { |_card| print '* ' }
    puts ''
  end

  def open_cards
    puts 'Кврты игрока'
    @hand1.cards.each { |card| print "#{card.rank + card.siute} " }
    puts "Кол-во очков #{@hand1.counting_points}"
    puts 'Карты дилера'
    @hand2.cards.each { |card| print "#{card.rank + card.siute} " }
    puts "Кол-во очков #{@hand2.counting_points}"
    show_winner
  end

  def show_winner
    winner
    if @winner
      puts "Победитель #{@wiiner.class}"
    else
      puts 'Ничья'
    end
  end
end
