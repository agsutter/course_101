VALID_CHOICES = %w(rock paper scissors lizard spock)

winner = {'rock'      => [VALID_CHOICES[3], 
                          VALID_CHOICES[2]],
          'paper'     => [VALID_CHOICES[0],
                          VALID_CHOICES[4]],
          'scissors'  => [VALID_CHOICES[1],
                          VALID_CHOICES[3]],
          'lizard'    => [VALID_CHOICES[4],
                          VALID_CHOICES[1]],
          'spock'     => [VALID_CHOICES[0],
                          VALID_CHOICES[2]]
          }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second, hash)
  # second == hash[first][0] || second == hash[first][1]
  hash[second].include?(first)
end

def display_results(player, computer, hash)
  return prompt('You won!') if win?(computer, player, hash)
  return prompt('Computer won!') if win?(player, computer, hash) 
  prompt("It's a tie!")
end

loop do
  player_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player_choice = Kernel.gets().chomp().downcase()

    break if VALID_CHOICES.include?(player_choice)
    prompt("That's not a valid choice.")
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{player_choice}; Computer chose: #{computer_choice}")

  display_results(player_choice, computer_choice, winner)

  prompt('Do you want to play again?')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt('Thank you for playing. Good bye!')
