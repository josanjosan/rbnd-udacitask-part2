class UdaciList
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
    puts "InvalidItemType: type #{type} is not suported in UdaciList" if !@@types.include?(type)
    #raise UdaciListErrors::InvalidItemType, "type #{type} is not suported in UdaciList" if !@@types.include?(type)
    @items.push TodoItem.new(type, description, options) if type == "todo"
    @items.push EventItem.new(type, description, options) if type == "event"
    @items.push LinkItem.new(type, description, options) if type == "link"
  end
  def delete(index)
    puts "IndexExceedsListSize: list has less than #{index} items" if index > @items.count
    #raise UdaciListErrors::IndexExceedsListSize, "list has less than #{index} items" if index > @items.count
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

  def filter(type)
    puts "InvalidItemType: type #{type} is not suported in UdaciList" if !@@types.include?(type)
    #raise UdaciListErrors::InvalidItemType, "type #{type} is not suported in UdaciList" if !@@types.include?(type)
    filtered_items = @items.select {|item| item.type == type}
    puts "NoTypeItem: there are currently no items of type \"#{type}\" in \"#{self.title}\"" if filtered_items.count == 0 and @@types.include?(type)
    #raise UdaciListErrors::NoTypeItem, "there are currently no items of type \"#{type}\" in \"#{self.title}\"" if filtered_type.count == 0
    filtered_list = UdaciList.new(title: self.title)
    filtered_items.each {|item| filtered_list.items.push(item)}
    return filtered_list
  end

  private

  def add_type(type)
    @@types.push(type) if !@@types.include?(type)
  end
end
