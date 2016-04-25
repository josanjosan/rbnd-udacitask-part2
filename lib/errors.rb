module UdaciListErrors
  # Error classes go here
  class InvalidItemType < StandardError
  end

  class IndexExceedsListSize < StandardError
  end

  class InvalidPriorityValue < StandardError
  end

  class NoTypeItem < StandardError
  end

  class NoDateItem < StandardError
  end

end
