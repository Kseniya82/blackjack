require_relative 'messages'
module DealerLogics
  include Messages

  def dealer_course
    if @hand2.counting_points < 17 && @hand2.cards.size < 3
      @deck.give_card(@hand2)
    else
      pass_course
    end
  end

  def pass_course
    show_pass_course(@dealer)
    user_course
  end
end
