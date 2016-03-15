module PlanningsHelper
  def get_div_width(planning, time, poste)
    original = number_of_dudes(planning, time, poste)
    before = number_of_dudes(planning, time - 15.minutes, poste)
    w = 15
    return 0 if original == 0 || original == before
    while true
      time += 15.minutes
      later = number_of_dudes(planning, time, poste)
      return w if later != original
      w += 15
    end
  end

  def number_of_dudes(planning, time, poste)
    Shift.where("planning_id = :planning_id AND starts_at <= :start_time AND ends_at > :end_time AND poste_id = :poste_id",
  {planning_id: planning.id, start_time: time, end_time: time, poste_id: poste.id}).count
  end

  def planning_color(planning)
    if planning.start_date > Date.today
      return "prevision"
    elsif planning.end_date < Date.today
      return "archive"
    else
      return "ongoing"
    end
  end

  def french_months(date)
    case date
      when "January" then "janvier"
      when "February" then "février"
      when "March" then "mars"
      when "April" then "avril"
      when "May" then "mai"
      when "June" then "juin"
      when "July" then "juillet"
      when "August" then "août"
      when "September" then "septembre"
      when "October" then "octobre"
      when "November" then "novembre"
      when "December" then "décembre"
      else date
    end
  end

  def french_mn(date)
    case date
      when "Jan" then "jan"
      when "Feb" then "fev"
      when "Mar" then "mar"
      when "Apr" then "avr"
      when "May" then "mai"
      when "Jun" then "juin"
      when "Jul" then "juil"
      when "Aug" then "août"
      when "Sep" then "sep"
      when "Oct" then "oct"
      when "Nov" then "nov"
      when "Dec" then "déc"
      else date
    end
  end

  def french_days(date)
    case date
      when "Monday" then "Lundi"
      when "Tuesday" then "Mardi"
      when "Wednesday" then "Mercredi"
      when "Thursday" then "Jeudi"
      when "Friday" then "Vendredi"
      when "Saturday" then "Samedi"
      when "Sunday" then "Dimanche"
      else date
    end
  end

  def color_by_letter(user)
    alpha = ("a".."z").to_a
    letter = user.first_name[0].downcase
    index = alpha.find_index(letter)
    return COLORS[index % COLORS.length]
  end
end
