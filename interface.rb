class Interface

  def ask_name
    puts 'Вееедите Ваше имя'
  end

  def receive_name
    gets.chomp
  end

  def show_menu(menu)
    puts 'Выберите пункт меню или 0 для выхода'
    index = 1
    menu.each do |menu_item|
      puts "#{index} - #{menu_item[:title]}"
      index += 1
    end
  end

  def receive_choice
    gets.to_i
  end

  def show_pass_course(player)
    puts "#{player.name} пропускает ход"
  end

  def show_cards(player, dealer)
    puts 'Кврты игрока'
    player.hand.cards.each { |card| print "#{card.rank + card.siute} " }
    puts ''
    puts "Кол-во очков #{player.points}"
    puts 'Карты дилера'
    dealer.hand.cards.each { |_card| print '* ' }
    puts ''
  end

  def show_open_cards(player, dealer)
    puts 'Кврты игрока'
    player.hand.cards.each { |card| print "#{card.rank + card.siute} " }
    puts ''
    puts "Кол-во очков #{player.points}"
    puts 'Карты дилера'
    dealer.hand.cards.each { |card| print "#{card.rank + card.siute} " }
    puts ''
    puts "Кол-во очков #{dealer.points}"
  end

  def show_give_card(player)
    puts "#{player.name} берет карту"
  end

  def show_winner(winner)
    puts "Победитель #{winner.name}"
  end

  def show_draw
    puts 'Ничья'
  end

  def ask_new_game
    puts 'Введите 1, если хотите начать новую игру, 0 для отмены'
  end
end
