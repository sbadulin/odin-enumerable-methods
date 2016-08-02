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

  def my_any?
    flag_bool = true
    for e in self
      if block_given?
        flag_bool = false if e.nil? || e == false
        (yield e) == true ? flag_bool = true : flag_bool = false
      end
    end
    flag_bool
  end

  def my_none?
    flag_bool = true
    for e in self
      if block_given?
        if e.nil? || e == false || ((yield e) == false)
          flag_bool = true
        else
          flag_bool = false
          break
        end
      else
        if e == true
          flag_bool = false
          break
        else
          flag_bool = true
        end
      end
    end
    flag_bool
  end

end

puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
puts [].my_none?                                           #=> true
puts [nil].my_none?                                        #=> true
puts [nil, false].my_none?                                 #=> true
puts [nil, false, true].my_none?                           #=> false
