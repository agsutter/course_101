require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def prompt(key, additional_param = '')
  message = messages(key, LANGUAGE)
  puts "=> #{message}#{additional_param}"
end

def integer?(input)
  input.to_s.to_i == input
end

def float?(input)
  input.to_s.to_f == input
end

def string_as_number?(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

def valid_input?(input)
  integer?(input) || float?(input) || string_as_number?(input)
end

def round_up?(number)
  return number.to_i if number.to_s.reverse.to_i == 0
  format('%.2f', number.to_f)
end

def print_operation(operation)
  case operation
  when 1 then prompt('add', '...')
  when 2 then prompt('subtract', '...')
  when 3 then prompt('multiply', '...')
  when 4 then prompt('divide', '...')
  end
end

prompt('welcome')
name = ''

loop do
  name = gets.chomp
  break if !name.empty?
  prompt('valid_name')
end

prompt('greet', name)

number1 = nil
number2 = nil

loop do
  loop do
    prompt('get_number_1')
    number1 = gets.chomp
    break if valid_input?(number1)
    prompt('invalid_number')
  end

  loop do
    prompt('get_number_2')
    number2 = gets.chomp
    break if valid_input?(number2)
    prompt('invalid_number')
  end

  prompt('number_1', number1)
  prompt('number_2', number2)

  prompt('operator_prompt')
  operator = nil

  loop do
    operator = gets.chomp.to_i
    break if valid_input?(operator) && (1..4).cover?(operator)
    prompt('invalid_operator')
    prompt('operator')
  end

  result = case operator
           when 1
             number1.to_f + number2.to_f
           when 2
             number1.to_f - number2.to_f
           when 3
             number1.to_f * number2.to_f
           when 4
             number1.to_f / number2.to_f
           end

  print_operation(operator)
  sleep(1)
  prompt('results', round_up?(result))

  prompt('again')
  response = gets.chomp

  break unless response.downcase.start_with?('y')
end

prompt('goodbye')
