require_relative 'messages'
module UserMenu
  include Messages
  USER_MENU = [
    { handler: :user_pass_course, title: 'Пропустить ход' },
    { handler: :user_give_card, title: 'Взять карту' },
    { handler: :user_open_cards, title: 'Открыть карты' }
  ].freeze

  ERROR_CHOICE = 'Неверный выбор'.freeze

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
    show_pass_course(@user)
    dealer_course
  end

  def user_give_card
    @deck.give_card(@user.hand) if @user.hand.cards.size < 3
  end

  def user_open_cards
    @user_open_cards = true
    open_cards
  end

  def new_game?
    false
  end
end
