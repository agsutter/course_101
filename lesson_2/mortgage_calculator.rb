def prompt(message)
  puts "=> #{message}"
end

def valid?(num)
  num.to_i != 0
end

def positive_number?(num)
  num.to_i.abs.to_s == num || num.to_f.abs.to_s == num
end

def valid_input?(input)
  return true if valid?(input) && positive_number?(input)
  prompt('Please enter a valid number.')
  false
end

def calculate_another_loan?(question, array1, array2)
  prompt(question)
  answer = gets.chomp.downcase
  if array1.include?(answer)
    true
  elsif array2.include?(answer)
    false
  elsif answer != array1 || answer != array2
    prompt("Hmmm...I'm not sure what you want to do.")
    prompt("Will you answer the question more clearly? Enter 'y' or 'n'")
    calculate_another_loan?(question, array1, array2)
  end
end

def duration_months(duration)
  remainder = duration.to_f % duration.to_i
  total_months = (duration.to_i * 12) + (remainder * 12)
  total_months.to_f.round(2)
end

prompt('Welcome to the mortgage calculator!')

loop do
  loan_amount = ''
  prompt('What is the loan amount?')
  loop do
    loan_amount = gets.chomp
    return loan_amount.slice!('$') if loan_amount.include?('$')
    break if valid_input?(loan_amount)
  end
  prompt("Your requested loan amount is $#{format('%.2f', loan_amount.to_f)}.")

  loan_duration = ''
  loop do
    prompt('What is the loan duration (in years)?')
    loan_duration = gets.chomp
    loan_duration = loan_duration.split.first
    break if valid_input?(loan_duration)
  end
  prompt("You will be paying off your loan in #{loan_duration} years,")
  prompt("or #{duration_months(loan_duration)} months.")

  apr = ''
  loop do
    prompt('What is the yearly interest rate?')
    prompt("Write '5' for 5%, '2.5' for 2.5%, etc...")
    apr = gets.chomp
    break if valid_input?(apr)
  end
  monthly_interest = (apr.to_f / 100) / 12
  prompt("Your monthly interest will be #{(monthly_interest * 100).round(4)}%.")

  monthly_payment = loan_amount.to_f *
                    (monthly_interest /
                    (1 - (1 + monthly_interest)**-
                    duration_months(loan_duration)))

  prompt("You will need to pay $#{monthly_payment.to_f.round(2)} each month.")

  question = 'Would you like to calculate a different mortgage? (Y/N)'

  negative    = ['no', 'negative', 'nah', 'x', 'n']
  affirmative = ['yes', 'yeah', 'yep', 'ya', 'y', 'ye']
  break if calculate_another_loan?(question, negative, affirmative)
end
