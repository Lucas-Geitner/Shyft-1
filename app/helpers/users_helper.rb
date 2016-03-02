module UsersHelper
  def remaining_hours_class(h)
    if h > 0
      return "under-limit"
    elsif h > -5
      return "almost-limit"
    else
      return "hours-left"
    end
  end
  def hours_card_class(h)
    if h > 0
      return "over-hours-limit"
    elsif h > -5
      return "card-almost-limit"
    else
      return ""
    end
  end
end
