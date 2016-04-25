class UdaciList
  include Listable
  attr_reader :title, :items
  @@types = []
  @@types.push('todo')
  @@types.push('event')
  @@types.push('link')

  def self.types
    @@types
  end

  def initialize(options={})
    options[:title] ? @title  = options[:title] : @title = "Untitled List"
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    checks_valid_item(type)
    @items.push TodoItem.new(type, description, options) if type == "todo"
    @items.push EventItem.new(type, description, options) if type == "event"
    @items.push LinkItem.new(type, description, options) if type == "link"
  end
  
  def delete(index)
    puts "IndexExceedsListSize: \"#{self.title}\" has less than #{index} items" if index > @items.count
    #raise UdaciListErrors::IndexExceedsListSize, "\"#{self.title}\" has less than #{index} items" if index > @items.count
    @items.delete_at(index - 1)
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def all_table
    rows = []
    @items.each_with_index do |item, position|
      rows.push([position + 1, "#{item.type.capitalize}: #{item.description.downcase}", format_to_table(item)])
    end
    table = Terminal::Table.new(title: self.title, rows: rows)
    puts table
  end

  def filter(type)
    checks_valid_item(type)
    filtered_items = @items.select {|item| item.type == type}
    puts "NoTypeItem: there are currently no items of type \"#{type}\" in \"#{self.title}\"" if filtered_items.count == 0 and @@types.include?(type)
    #raise UdaciListErrors::NoTypeItem, "there are currently no items of type \"#{type}\" in \"#{self.title}\"" if filtered_type.count == 0
    filtered_list = UdaciList.new(title: self.title)
    filtered_items.each {|item| filtered_list.items.push(item)}
    return filtered_list
  end

  def soonest(type)
    checks_valid_item(type)
    puts "NoDateItem: type #{type} does not support dates" if type == "link"
    #raise UdaciListErrors::NoDateItem, "type #{type} does not support dates" if type == "link"
    dates = nil
    dates = self.filter(type).items.map { |item| item.start_date } if type == "event"
    dates = self.filter(type).items.map { |item| item.due } if type == "todo"
    soonest_date = dates.min if dates != nil
    soonest_item = self.filter(type).items.select { |item| item.start_date == soonest_date and type == "event" } if type == "event"
    soonest_item = self.filter(type).items.select { |item| item.due == soonest_date and type == "todo" } if type == "todo"
    puts "Soonest #{type} is \"#{soonest_item[0].description}\" -> #{soonest_date.strftime("%D")}"  if dates != nil
  end

  private

  def add_type(type)
    @@types.push(type) if !@@types.include?(type)
  end

  def checks_valid_item(type)
    puts "InvalidItemType: type #{type} is not suported in UdaciList" if !@@types.include?(type)
    #raise UdaciListErrors::InvalidItemType, "type #{type} is not suported in UdaciList" if !@@types.include?(type)
  end

end
