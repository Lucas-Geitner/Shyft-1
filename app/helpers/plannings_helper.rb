module PlanningsHelper
  def get_div_width(planning, time, poste)
    original = Shift.where("planning_id = :planning_id AND starts_at <= :start_time AND ends_at > :end_time AND poste_id = :poste_id",
  {planning_id: planning.id, start_time: time, end_time: time, poste_id: poste.id}).count
    w = 30
    return 0 if original == 0
    while true
      time += 30.minutes
      new = Shift.where("planning_id = :planning_id AND starts_at <= :start_time AND ends_at > :end_time AND poste_id = :poste_id",
  {planning_id: planning.id, start_time: time, end_time: time, poste_id: poste.id}).count
      return w if new != original
      w += 30
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

  def french_days(date)
    case date
      when "Monday" then "lundi"
      when "Tuesday" then "mardi"
      when "Wednesday" then "mercredi"
      when "Thursday" then "jeudi"
      when "Friday" then "vendredi"
      when "Saturday" then "samedi"
      when "Sunday" then "dimanche"
      else date
    end
  end
end
