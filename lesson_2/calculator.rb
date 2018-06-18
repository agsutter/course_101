# ask the user for two numbers
# as the user for an operation to perform
# perform the operation on the two numbers
# output the results

Kernal.gets()

Kernal.puts("Welcome to the Calculator!")

Kernal.puts("What's the first number?")
number1 = Kernal.gets().chomp()

Kernal.puts("What's the second number?")
number2 = Kernal.gets().chomp()

Kernal.puts("What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernal.gets().chomp()

if operator    == '1'
  result = number1.to_i() + number2.to_i()
elsif operator == '2'
  result = number1.to_i() - number2.to_i()
elsif operator == '3'
  result = number1.to_i() * number2.to_i()
elsif operator == '4'
  result = number1.to_f() / number2.to_f()
end

Kernal.puts("The result is #{result}.")



