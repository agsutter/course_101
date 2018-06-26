def prompt(message)
  puts "=> #{message}"
end

def valid?(num)
  num.to_i != 0
end

def positive?(num)
  num.to_i.abs.to_s == num || num.to_f.abs.to_s == num
end

def valid_invalid(variable)
  if valid?(variable) && positive?(variable)
    true
  else
    prompt('Please enter a valid number.')
    false
  end
end

prompt('Welcome to the mortgage calculator!')

loop do
  loan_amount = ''
  prompt('What is the loan amount?')
  loop do
    loan_amount = gets.chomp
    if loan_amount.include?('$')
      loan_amount.slice!('$')
    end
    break if valid_invalid(loan_amount) == true
  end
  prompt("Your requested loan amount is $#{loan_amount.to_f.round(2)}.")

  loan_duration = ''
  loop do
    prompt('What is the loan duration (in years)?')
    loan_duration = gets.chomp
    loan_duration = loan_duration.split.first
    break if valid_invalid(loan_duration) == true
  end
  duration_months = loan_duration.to_i * 12
  prompt("You will be paying off your loan in #{loan_duration} years,")
  prompt("or #{duration_months} months.")

  apr = ''
  loop do
    prompt('What is the yearly interest rate?')
    prompt("Write '5' for 5%, '2.5' for 2.5%, etc...")
    apr = gets.chomp
    break if valid_invalid(apr) == true
  end
  monthly_interest = (apr.to_f / 100) / 12
  prompt("Your monthly interest will be #{(monthly_interest * 100).round(4)}%.")

  p = loan_amount.to_f
  n = duration_months
  j = monthly_interest

  m = p * (j / (1 - (1 + j)**-n))

  prompt("You will need to pay $#{m.to_f.round(2)} each month.")

  prompt('Would you like to calculate a different mortgage?')
  answer = gets.chomp
  break if answer[0..1].casecmp?('no')
end
