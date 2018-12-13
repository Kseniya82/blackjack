class Interface
  USER_MENU = [
    { handler: :user_pass_course, title: 'Пропустить ход' },
    { handler: :user_give_card, title: 'Взять карту' },
    { handler: :user_open_cards, title: 'Открыть карты' }
  ].freeze

  ERROR_CHOICE = 'Неверный выбор'.freeze

  def ask_name
    puts 'Вееедите Ваше имя'
  end

  def receive_name
    gets.chomp
  end

  def show_menu
    puts 'Выберите пункт меню или 0 для выхода'
    index = 1
    USER_MENU.each do |menu_item|
      puts "#{index} - #{menu_item[:title]}"
      index += 1
    end
  end

  def receive_choice
    gets.to_i
  end

  def show_pass_course(player)
    puts "#{player.class} пропускает ход"
  end

  def show_cards(hand1, hand2)
    puts 'Кврты игрока'
    hand1.cards.each { |card| print "#{card.rank + card.siute} " }
    puts ''
    puts "Кол-во очков #{hand1.counting_points}"
    puts 'Карты дилера'
    hand2.cards.each { |_card| print '* ' }
    puts ''
  end

  def show_open_cards(hand1, hand2)
    puts 'Кврты игрока'
    hand1.cards.each { |card| print "#{card.rank + card.siute} " }
    puts ''
    puts "Кол-во очков #{hand1.counting_points}"
    puts 'Карты дилера'
    hand2.cards.each { |card| print "#{card.rank + card.siute} " }
    puts ''
    puts "Кол-во очков #{hand2.counting_points}"
  end

  def show_give_card(player)
    puts "#{player.class} берет карту"
  end

  def show_winner(winner)
    puts "Победитель #{winner.class}"
  end

 def show_draw
   puts 'Ничья'
 end

 def ask_new_game
   puts 'Введите 1, если хотите начать новую игру, 0 для отмены'
 end

end
