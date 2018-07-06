VALID_CHOICES = [[1, 'rock'],
                 [2, 'paper'],
                 [3, 'scissors'],
                 [4, 'lizard'],
                 [5, 'spock']]

WINNER = { 'rock' => [VALID_CHOICES[3][1],
                      VALID_CHOICES[2][1]],
           'paper' => [VALID_CHOICES[0][1],
                       VALID_CHOICES[4][1]],
           'scissors' => [VALID_CHOICES[1][1],
                          VALID_CHOICES[3][1]],
           'lizard' => [VALID_CHOICES[4][1],
                        VALID_CHOICES[1][1]],
           'spock' => [VALID_CHOICES[0][1],
                       VALID_CHOICES[2][1]] }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def number_provided(number)
  number.to_i.abs.to_s == number.to_s && (1..5).cover?(number.to_i)
end

def return_choice(input, given_array)
  return input = given_array[input.to_i - 1][1] if number_provided(input)
  choices = given_array.map(&:last)
  choices.any? do |choice|
    break if input == 's'
    return input = choice if choice[0] == input || choice == input
  end
  prompt("Please write the full word or associated number.") if input == 's'
end

def player_chooses(given_array)
  choices_array = given_array.map { |num, item| "#{num}. #{item}" }
  prompt("Choose one: #{choices_array.join(', ')}")
  choice = gets.chomp.downcase
  choice = return_choice(choice, given_array)
  return choice if given_array.flatten.include?(choice)
  prompt("That's not a valid choice.")
  player_chooses(given_array)
end

def computer_chooses(given_array)
  computer_choice = given_array.map(&:last)
  computer_choice.sample
end

def win?(first, second)
  WINNER[second].include?(first)
end

def display_results(player, computer)
  return prompt('You won!') if win?(computer, player)
  return prompt('Computer won!') if win?(player, computer)
  prompt("It's a tie!")
end

def keep_score(score_hash, player, computer)
  return score_hash[:computer] += 1 if win?(player, computer)
  return score_hash[:player] += 1 if win?(computer, player)
end

def print_score(score_hash)
  prompt("Your score: #{score_hash[:player]}")
  prompt("Computer's score: #{score_hash[:computer]}")
end

def grand_winner(score_hash)
  prompt("You are the grand winner.") if score_hash[:player] >= 5
  prompt("The computer is the grand winner.") if score_hash[:computer] >= 5
end

def stop_playing?
  prompt("Do you want to play again? 'y' or 'n'")
  answer = Kernel.gets().chomp()
  return true if answer.downcase == 'n'
  return false if answer.downcase == 'y'
  prompt("Please answer either 'y' or 'n'")
  stop_playing?
end

score = { player: 0, computer: 0 }

loop do
  player_choice = player_chooses(VALID_CHOICES)
  computer_choice = computer_chooses(VALID_CHOICES)

  prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")

  display_results(player_choice, computer_choice)
  keep_score(score, player_choice, computer_choice)
  print_score(score)
  grand_winner(score)
  break if score[:player] >= 5 || score[:computer] >= 5
  break if stop_playing?
end

prompt('Thank you for playing. Good bye!')
