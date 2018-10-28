# # PSEUDO-CODE
#   1. Initialize deck
#   2. Deal cards to player and dealer
#   3. Player turn: hit or stay
#     - repeat until bust or "stay"
#   4. If player bust, dealer wins.
#   5. Dealer turn: hit or stay
#     - repeat until total >= 17
#   6. If dealer bust, player wins.
#   7. Compare cards and declare winner.

cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

DECK = { hearts: cards,
         diamonds: cards,
         clubs: cards,
         spades: cards }

def prompt(msg)
  puts "=> #{msg}"
end

def joinand(array, symbol = ', ', word = 'and')
  return array[0] if array.size <= 1
  return array.join(" #{word} ") if array.size == 2
  "#{array[0, array.size - 1].join(symbol)}#{symbol}#{word} #{array[-1]}"
end

def initialize_deck
  DECK.to_a.map { |cards| cards[1] }.flatten!.shuffle!
end

def ace_value(sum)
  (sum += 11) >= 22 ? 1 : 11
end

def cards_sum(hand)
  sum = if hand.any? { |i| i.is_a?(Integer) }
          hand.select { |card| card.is_a?(Integer) }.reduce(:+)
        else
          0
        end

  hand.each do |card|
    if card.is_a?(Symbol)
      sum += ace_value(sum) if card == :ace
      sum += 10 if card != :ace
    end
  end
  sum
end

def bust?(total)
  total >= 22
end

def draw_card(deck, hand)
  hand << deck.pop
end

def player_turn(deck, hand)
  prompt "Would you like to hit or stay?"
  play = gets.chomp.downcase
  case play
  when 'hit'
    draw_card(deck, hand)
    display_cards(hand, 'Your')
  when 'stay' then return deck
  else prompt("That is not a valid response.")
  end
  return deck if bust?(cards_sum(hand))
  player_turn(deck, hand)
end

def dealer_turn(deck, hand)
  display_cards(hand, "The dealer's")
  return deck if bust?(cards_sum(hand)) || cards_sum(hand) >= 17
  draw_card(deck, hand)
  prompt "The dealer hits."
  dealer_turn(deck, hand)
end

def display_cards(hand, player)
  prompt "#{player} cards are #{joinand(hand)}, which total #{cards_sum(hand)}."
end

def detect_winner(dealer, player)
  dealer_total = cards_sum(dealer)
  player_total = cards_sum(player)

  if player_total > 21
    :player_busted
  elsif dealer_total > 21
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_results(dealer, player)
  result = detect_winner(dealer, player)

  case result
  when :player_busted
    prompt "You busted. The dealer wins!"
  when :dealer_busted
    prompt "The dealer busted. You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "The dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

loop do
  loop do
    shuffled_cards = initialize_deck
    player_cards = []
    dealer_cards = []

    2.times { |_| draw_card(shuffled_cards, dealer_cards) }
    2.times { |_| draw_card(shuffled_cards, player_cards) }

    prompt "The dealer has a #{dealer_cards[0]}."

    display_cards(player_cards, 'Your')
    prompt "It's your turn."
    player_turn(shuffled_cards, player_cards)

    if bust?(cards_sum(player_cards))
      display_results(dealer_cards, player_cards)
      break
    end

    prompt "It's the dealer's turn."
    dealer_turn(shuffled_cards, dealer_cards)

    display_results(dealer_cards, player_cards)
    break
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break if answer.downcase.start_with?('n')
  puts '===================='
end
