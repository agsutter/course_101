# ask the user for two numbers
# as the user for an operation to perform
# perform the operation on the two numbers
# output the results

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yaml')

LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt_no_yaml(message)
  Kernel.puts("=> #{message}")
end

def prompt(key)
  message = messages(key, LANGUAGE)
  prompt_no_yaml(message)
end

def valid_number?(num)
  num.to_i.to_s == num
end

def number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end
prompt('welcome')

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt('valid_name')
  else
    break
  end
end

prompt_no_yaml("Hi, #{name}") 

loop do # main loop
  number1 = ''
  loop do
    prompt('number_1')
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt('invalid_number')
    end
  end

  number2 = ''
  loop do
    prompt('number_2')
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt('invalid_number')
    end
  end

  prompt('operator_prompt')
  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('operator')
    end
  end

  prompt_no_yaml("#{operation_to_message(operator)} the two numbers...")

  result =  case operator
            when '1'
              number1.to_i() + number2.to_i()
            when '2'
              number1.to_i() - number2.to_i()
            when '3'
              number1.to_i() * number2.to_i()
            when '4'
              number1.to_f() / number2.to_f()
            end

  prompt_no_yaml("The result is #{result}.")

  prompt('again')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt('goodbye')
