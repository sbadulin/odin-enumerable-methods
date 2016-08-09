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

  def my_count (*args)

    # If a block is given, counts the number of elements for which the block returns a true value
    if block_given?
      arr_with_block = []
      self.my_each { |e| arr_with_block << e if (yield e) == true }
      arr_with_block.size

    # Returns the number of elements if no args and no block
    elsif args.empty?
      self.length

    # If an argument is given, counts the number of elements
    else
      arr_with_arg = []
      self.my_each { |e| arr_with_arg << e if e == args[0] }
      arr_with_arg.size
    end
    
  end

  def my_map

  end

  def my_inject

  end

end

ary = [1, 2, 4, 2]
p ary.my_count                  #=> 4
p ary.my_count(2)               #=> 2
p ary.my_count { |x| x%2 == 0 } #=> 3
