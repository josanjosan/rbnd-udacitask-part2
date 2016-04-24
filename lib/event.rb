class EventItem
  include Listable
  attr_reader :type, :description, :start_date, :end_date

  def initialize(type, description, options={})
    @type = type
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end

  def details
    format_description(@description) + "event dates: " + format_date(@start_date, @end_date)
  end
end
