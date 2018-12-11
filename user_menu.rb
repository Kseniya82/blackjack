module UserMenu

  USER_MENU = [
    { handler: :user_pass_course, title: 'Пропустить ход' },
    { handler: :user_give_card, title: 'Взять карту' },
    { handler: :open_cards?, title: 'Открыть карты' }
  ].freeze

  ERROR_CHOICE = 'Неверный выбор'

  def user_course
    show_menu_items(USER_MENU)
    choice = gets.to_i
    # raise ERROR_CHOICE unless (1 .. USER_MENU.size).include?(choice)
    selected_item = USER_MENU[choice - 1]
    send(selected_item[:handler]) if selected_item
  end

  def show_menu_items(menu)
    puts 'Выберите пункт меню или 0 для выхода'
    index = 1
    menu.each do |menu_item|
      puts "#{index} - #{menu_item[:title]}"
      index += 1
    end
  end

  def user_pass_course
    show_pass_course(self)
    dealer_course
  end

  def user_give_card
    give_card(self) if self.cards.size < 3
  end

  def open_cards?
    true
  end

end
