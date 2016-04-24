class TodoItem
  include Listable
  attr_reader :type, :description, :due, :priority
  @@priority_levels = ["low", "medium", "high", nil]

  def initialize(type, description, options={})
    @type = type
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    puts "InvalidPriorityValue: \"#{options[:priority]}\" is not a valid priority level" if !@@priority_levels.include?(options[:priority])
    #raise UdaciListErrors::InvalidPriorityValue "\"#{options[:priority]}\" is not a valid priority level" if !@@priority_levels.include?(options[:priority])
    @priority = options[:priority]
  end
  
  def details
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority).to_s
  end

end
