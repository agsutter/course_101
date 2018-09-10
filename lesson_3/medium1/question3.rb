# Alan wrote the following method, which was intended to show all of the factors of the input number:

# Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to
# change the loop. How can you make this work without using begin/end/until? Note that we're not
# looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully
# instead of raising an exception or going into an infinite loop.

def factors(number)
  dividend = number
  divisors = []
  while number >= 1
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
    break if dividend == 0
  end
  divisors
end

p factors(7)
p factors(0)
