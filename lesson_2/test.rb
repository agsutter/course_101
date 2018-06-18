def find_greatest(numbers)
  saved_number = nil

  numbers.each do |num|
    saved_number ||= num  # assign to first value
    if saved_number >= num
      next
    else
      saved_number = num
    end
  end

  saved_number
end

num = [1, 3, 2, 5, 2.5, 5.7, 0]

puts find_greatest(num)