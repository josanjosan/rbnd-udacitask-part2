module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_date(date_1, date_2 = nil)
    date_1 ? dates = date_1.strftime("%D") : dates = "No due date"
    dates << " -- " + date_2.strftime("%D") if date_2
    dates = "N/A" if !dates
    return dates
  end

  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end

end
