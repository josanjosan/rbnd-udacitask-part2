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
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
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

  private

  def add_type(type)
    @@types.push(type) if !@@types.include?(type)
  end
end
