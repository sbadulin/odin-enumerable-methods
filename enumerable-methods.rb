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

  def my_select
    if block_given?
      # create array for selected value
      ary = []
      self.my_each { |e|
        ary << e if (yield e) == true
      }
      ary
    else
      self.to_enum
    end
  end

  def my_all?
    flag_bool = true
    for e in self
      if e.nil? || e == false
        flag_bool = false
        break
      elsif block_given?
          flag_bool = false if (yield e) == false
      end
    end
    flag_bool
  end

end

puts %w[cat dog].my_all? { |word| word.length >= 4 }
puts %w[cat dog].all? { |word| word.length >= 4 }
puts [nil, true, 99].all?
puts [nil, true, 99].my_all?
