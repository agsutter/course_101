def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    numbers[counter] *= 2

    counter += 1
  end

  numbers
end

numbers = [1, 2, 3, 4, 5, 6, 7]
puts "The array before the method: #{numbers}"

double_numbers!(numbers)
puts "The array after the method: #{numbers}"