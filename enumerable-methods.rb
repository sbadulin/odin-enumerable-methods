module Enumerable

  def my_each
    if block_given?
      for i in self
        yield i
      end
    else
      self.to_enum
    end
  end

  def my_each_with_index
    if block_given?
      # add index to pass it to block
      index = 0
      for i in self
        yield [i, index]
        index += 1
      end
    else
      self.to_enum
    end
  end

end
