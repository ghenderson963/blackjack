#blackJack
require "pry"

player_hand  = []
dealer_hand = []
dealer_total_count = 0
player_total_count = 0

def build_decks(number_of_decks)
  puts "Building #{number_of_decks} decks."
  suit = ["spades", "diamonds", "clubs", "hearts"]
  rank = ['2','3','4','5','6','7','8','9','jack','queen','king','ace']
  count = 1
  total_deck = []
  while count <= number_of_decks
    full_deck1 = suit.product(rank)
    total_deck = full_deck1.concat(total_deck)
    count = count + 1
  end
  total_deck.count
return total_deck
end

def determine_number_of_decks
begin
puts "How many decks do you want to play with?  Enter a number 1 -4."
number_of_decks = gets.chomp.to_i
end while number_of_decks == 0
return number_of_decks
end

def show_wait_cursor(seconds,fps=10)
  chars = %w[| / - \\]
  delay = 1.0/fps
  (seconds*fps).round.times{ |i|
    print chars[i % chars.length]
    sleep delay
    print "\b"
  }
end

def shuffle_decks!(total_decks)
  total_decks.shuffle!
  puts "Shuffling -"
  show_wait_cursor(1)
  total_decks.reverse!
  total_decks.shuffle!
  show_wait_cursor(1)
  puts "Shuffling again!"
end

# def initial_player_deal(total_decks, player_hand)
#  card = total_decks.pop
#  player_hand.push(card)
#  card = total_decks.pop
#  player_hand.push(card)

# end

# def initial_dealer_deal(total_decks,dealer_hand)
#   card = total_decks.pop
#   dealer_hand.push(card)
#   card = total_decks.pop
#   dealer_hand.push(card)
# end


def deal_card!(total_decks,hand)
  number_of_cards = hand.length
  show_wait_cursor(0.5)


  hand[number_of_cards ] = total_decks.pop
end

def announce_player_cards(hand)
    count = 1
    puts "\e[H\e[2J"
    puts "You have a:"
    hand.each  do |card|
      puts "#{card[count]} of #{card[0]}"
      count =+ 1
    end
end

def announce_dealer_cards(hand)
  if hand.count > 2
    count = 1
    puts "The dealer has a: "
    hand.each do |card|
      puts "#{card[count]} of #{card[0]}"
      count =+ 1
    end
  else
     puts "The dealer has a #{hand[1][1]} of #{hand[1][0]} showing"
  end
end

def count_up_cards(hand)
  total = 0
  count = 0
  hand.each do |card|
    current_value = card[1]
    if (current_value == "jack") ||  (current_value == "queen" )  ||  (current_value == "king") || (current_value== "ace")
      face_card_total = convert_face_cards_to_int(current_value, total)
      total = total + face_card_total.to_i
    else
      total = current_value .to_i+ total
    end
  end
  return total
end

def convert_face_cards_to_int(current_card,total)
  if (current_card == "jack" ) || (current_card == "queen") || (current_card == "king")
    current_card = 10
    return current_card
  elsif total > 21
      return 1
  else
      return 11
  end
end

def dealer_turn(dealer_hand, dealer_total_count)


end

def check_for_blackjack_or_bust(player_total_count)
  if player_total_count > 21
   puts "Busted! You lose!"
   return "s"
  elsif player_total_count == 21
    puts "Blackjack you win!"
    return "s"
  else
    return "h"
  end
end

def dealer_decide_stay_or_hit(dealer_total_count,dealer_hand,total_decks)
  case
  when dealer_total_count <= 16
    puts "The dealer hits!"
    deal_card!(total_decks,dealer_hand)
  when dealer_total_count > 16
    puts "Dealer stays!"
  when dealer_total_count == 21
    puts "Dealer has blackjack!"
  end
end

def check_for_winner(player_total_count, dealer_total_count)
  case
  when (player_total_count > 21)
    puts "Busted! You lose!"
  when (dealer_total_count > 21)
    puts "Dealer Busted!  You Win!"
  when player_total_count > dealer_total_count
    puts "You win!"
  when dealer_total_count > player_total_count
    puts "The dealer wins"
   when
    dealer_total_count == player_total_count
    puts "No winners! BORING!"
  end
end

begin
  puts "\e[H\e[2J"
  number_of_decks = determine_number_of_decks
  total_decks = build_decks(number_of_decks)
  shuffle_decks!(total_decks)
  deal_card!(total_decks,player_hand)
  puts "Dealing a card to you!"
  deal_card!(total_decks,dealer_hand)
  puts "Dealing a card face down to the dealer"
  deal_card!(total_decks,player_hand)
  puts "dealing a card to you!"
  deal_card!(total_decks, dealer_hand)
  puts "dealing a card to the dealer"
  player_total_count = count_up_cards(player_hand)
  break if check_for_blackjack_or_bust(player_total_count) == 's'
  announce_player_cards(player_hand)
  announce_dealer_cards(dealer_hand)
  player_call = 0
  while player_call != "s"
    puts "Do you want to (S)tay or (H)it?"
    player_call = gets.chomp.downcase
    # puts "\e[H\e[2J"
    if player_call == "h"
      deal_card!(total_decks, player_hand)
      check_for_blackjack_or_bust(player_total_count)
      announce_player_cards(player_hand)
      announce_dealer_cards(dealer_hand)
      player_total_count = count_up_cards(player_hand)
      player_call = check_for_blackjack_or_bust(player_total_count)
    else
    end
  end
  dealer_total_count = count_up_cards(dealer_hand)
  # puts dealer_total_count
  announce_dealer_cards(dealer_hand)
  dealer_decide_stay_or_hit(dealer_total_count, dealer_hand, total_decks)
  announce_dealer_cards(dealer_hand)
  dealer_total_count = count_up_cards(dealer_hand)
  puts dealer_total_count
  puts "For a total of: #{dealer_total_count}"
  # check_for_winner(player_total_count, dealer_total_count)
  puts "Do you want to play again? (y)es or (n)o"
  play_again = gets.chomp.downcase
end while play_again != "n"


