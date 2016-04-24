module Listable
  # Listable methods go here
  def format_description(type, description)
    "#{type.capitalize}: #{description.downcase}".ljust(32)
  end

  def format_date(date_1, date_2 = nil)
    date_1 ? dates = date_1.strftime("%D") : dates = "No due date"
    dates << " -- " + date_2.strftime("%D") if date_2
    dates = "N/A" if !dates
    return dates
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end

end
