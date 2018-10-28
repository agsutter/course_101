require 'pry'

FIRST = 'choose'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # colums
                [[1, 5, 9], [3, 5, 7]]              # diagonals

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

score = { player: 0, computer: 0 }

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(array, symbol = ', ', word = 'or')
  return array[0] if array.size <= 1
  return array.join(" #{word} ") if array.size == 2
  "#{array[0, array.size - 1].join(symbol)}#{symbol}#{word} #{array[-1]}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def first?
  first = ''
  loop do
    prompt 'Choose who plays first: player or computer'
    first = gets.chomp.downcase
    break if first == 'player' || first == 'computer'
    prompt "Sorry, that's not a valid choice."
    prompt "Please type 'player' or 'computer'."
  end
  first
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def place_piece!(brd, player)
  player == 'player' ? player_places_piece!(brd) : computer_places_piece!(brd)
end

def alternate_player(player)
  return 'computer' if player == 'player'
  'player'
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}): "
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  sqr = if !!about_to_win?(brd, COMPUTER_MARKER)
          ai_offensive(brd)
        elsif !!about_to_win?(brd, PLAYER_MARKER)
          ai_defensive(brd)
        elsif brd[5] == INITIAL_MARKER
          5
        else
          empty_squares(brd).sample
        end

  brd[sqr] = COMPUTER_MARKER
end

# OUTPUTS THE ARRAY THAT HAS THE PLAYER'S NEXT WINNING MOVE
def about_to_win?(brd, user)
  winning_array = WINNING_LINES.map { |ln| ln.map { |i| brd[i] } }
  marked = winning_array.map { |ln| ln.count { |i| i == user } }
  fully_marked = winning_array.map { |ln| ln.count { |i| i != INITIAL_MARKER } }
  comparative_count = marked.zip fully_marked
  comparative_count.find_index { |array| array[0] == 2 && array[1] != 3 }
end

# FINDS WHICH SPACE IN THE player_about_to_win? ARRAY SHOULD BE DEFENDED
def ai_defensive(brd)
  to_mark = WINNING_LINES[about_to_win?(brd, PLAYER_MARKER)].select do |i|
    brd[i] == INITIAL_MARKER
  end
  to_mark.pop
end

def ai_offensive(brd)
  to_mark = WINNING_LINES[about_to_win?(brd, COMPUTER_MARKER)].select do |i|
    brd[i] == INITIAL_MARKER
  end
  to_mark.pop
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def keep_score(score, winner)
  return score[:computer] += 1 if winner == 'Computer'
  return score[:player] += 1 if winner == 'Player'
end

def print_score(score)
  prompt("Your score: #{score[:player]}")
  prompt("Computer's score: #{score[:computer]}")
end

def grand_winner(score)
  prompt("You are the grand winner.") if score[:player] >= 5
  prompt("The computer is the grand winner.") if score[:computer] >= 5
end

loop do
  current_player = FIRST
  if FIRST == 'choose'
    current_player = first?
  end

  board = initialize_board

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  keep_score(score, detect_winner(board))
  print_score(score)
  grand_winner(score)
  break if score[:player] >= 5 || score[:computer] >= 5

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break if answer.downcase.start_with?('n')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
