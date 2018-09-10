def multiply(numbers, multiply_by)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    doubled_numbers << numbers[counter] * multiply_by

    counter += 1
  end

  doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
number = 3
puts "The numbers to be multiplied are: #{my_numbers}"
puts "They will be multiplied by #{number}."
puts "The new array is #{multiply(my_numbers, number)}"