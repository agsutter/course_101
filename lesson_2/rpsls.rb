VALID_CHOICES = %w(rock paper scissors lizard spock)

WINNER = { 'rock' => [VALID_CHOICES[3],
                      VALID_CHOICES[2]],
           'paper' => [VALID_CHOICES[0],
                       VALID_CHOICES[4]],
           'scissors' => [VALID_CHOICES[1],
                          VALID_CHOICES[3]],
           'lizard' => [VALID_CHOICES[4],
                        VALID_CHOICES[1]],
           'spock' => [VALID_CHOICES[0],
                       VALID_CHOICES[2]] }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  WINNER[second].include?(first)
end

def display_results(player, computer)
  return prompt('You won!') if win?(computer, player)
  return prompt('Computer won!') if win?(player, computer)
  prompt("It's a tie!")
end

def first_letters(input, given_array)
  given_array.any? do |choice|
    break if input == 's'
    return input = choice if choice.start_with?(input)
  end
  return prompt('Please provide more letters for clarification') if input == 's'
end

def grand_winner(player, computer)
  @player1 = @player1 += 1 if win?(computer, player)
  @player2 = @player2 += 1 if win?(player, computer)
  prompt("Your score: #{@player1}")
  prompt("Computer's score: #{@player2}")
  prompt("You are the grand winner") if @player1 >= 5
  prompt("The computer is the grand winner") if @player2 >= 5
end

@player1 = 0
@player2 = 0
loop do
  player_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player_choice = Kernel.gets().chomp().downcase()
    player_choice = first_letters(player_choice, VALID_CHOICES)

    break if VALID_CHOICES.include?(player_choice)
    prompt("That's not a valid choice.")
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{player_choice}; Computer chose: #{computer_choice}")

  display_results(player_choice, computer_choice)
  grand_winner(player_choice, computer_choice)
  break if @player1 >= 5 || @player2 >= 5

  prompt('Do you want to play again?')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt('Thank you for playing. Good bye!')