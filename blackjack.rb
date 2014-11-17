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
  card_vals = hand.map  { |card| card[1] }
  total = 0
  card_vals.each do |value|
    if value == "ace"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end
  card_vals.select { |card| card == "ace" }.count.times do
    if total > 21
      total -= 10
    end
  end
  total
end

begin
  dealer_hand = []
  player_hand = []
  total_decks = []
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
  dealer_total_count = count_up_cards(dealer_hand)
  player_total_count = count_up_cards(player_hand)
  announce_player_cards(player_hand)
  if player_total_count == 21
    puts "Blackjack! You win!"
    exit
  end
  while player_total_count < 21
    announce_dealer_cards(dealer_hand)
    announce_player_cards(player_hand)
    puts "For a total of #{player_total_count}"
    puts "Do you want to (S)tay or (H)it?"
    player_call = gets.chomp.downcase
    if !["h", "s"].include?(player_call)
      puts "you must enter s or h"
      next
    end
    if player_call == "s"
      puts "You choose to stay"
      break
    end
    if player_total_count == 21
      puts "Blackjack! you win!"
      exit
    elsif player_total_count > 21
      puts "Busted! you loose!"
      exit
    end
    deal_card!(total_decks, player_hand)
    player_total_count = count_up_cards(player_hand)
    announce_player_cards(player_hand)
    announce_dealer_cards(dealer_hand)
    puts "You have #{player_total_count}"
  end
  if dealer_total_count == 21
    puts "Dealer has Blackjack!"
    exit
  end
  while dealer_total_count < 17
    puts "The dealer hits!"
    deal_card!(total_decks,dealer_hand)
    announce_dealer_cards(dealer_hand)
    dealer_total_count = count_up_cards(dealer_hand)
    puts "Dealer total is #{dealer_total_count}"
    if dealer_total_count == 21
      puts "Dealer has Blackjack!  You lose."
      break
    elsif  dealer_total_count > 21
      puts "Dealer has busted! You win."
     break
    end
    puts "The dealer stays on a:"
    announce_dealer_cards(dealer_hand)
  end
  if player_total_count > 21
    announce_player_cards(player_hand)
    puts "For a total of #{player_total_count}"
    announce_dealer_cards(dealer_hand)
    puts "For a total of #{dealer_total_count}"
    puts "You Busted! Sorry you lose!"
  elsif dealer_total_count > 21
    announce_player_cards(player_hand)
    puts "For a total of #{player_total_count}"
    announce_dealer_cards(dealer_hand)
    puts "For a total of #{dealer_total_count}"
    puts "You win! The dealer busted!"
  elsif player_total_count > dealer_total_count
    announce_player_cards(player_hand)
    puts "For a total of #{player_total_count}"
    announce_dealer_cards(dealer_hand)
    puts "For a total of #{dealer_total_count}"
    puts "You Win!"
  elsif player_total_count < dealer_total_count
    announce_player_cards(player_hand)
    puts "For a total of #{player_total_count}"
    announce_dealer_cards(dealer_hand)
    puts "For a total of #{dealer_total_count}"
    puts "Dealer Wins!"
  else player_total_count == dealer_total_count
    announce_player_cards(player_hand)
    puts "For a total of #{player_total_count}"
    announce_dealer_cards(dealer_hand)
    puts "For a total of #{dealer_total_count}"
    puts "Tie so BORING!"
  end
  puts "Would you like to play again?  (Y)es or (N)o"
  play_again = gets.chomp
end while play_again == 'y'



