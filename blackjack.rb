#blackJack
require "pry"

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

def shuffle_decks!(total_decks)
  total_decks.shuffle!
  total_decks.reverse!
  total_decks.shuffle!
  p total_decks
end

def initial_player_deal(total_decks, player_hand)
 card = total_decks.pop
 player_hand.push(card)
 card = total_decks.pop
 player_hand.push(card)

end

def initial_dealer_deal(total_decks,dealer_hand)
  card = total_decks.pop
  dealer_hand.push(card)
  card = total_decks.pop
  dealer_hand.push(card)
end


def deal_card!(total_decks,hand)
  number_of_cards = hand.length
  hand[number_of_cards ] = total_decks.pop
end

def announce_cards(player_hand,dealer_hand)
    count = 0
    puts " "
      puts "You have a #{player_hand[0][1]} of #{player_hand[0][0]} and a #{player_hand[1][1]} of #{player_hand[1][0]} showing"
binding.pry
puts " "
      puts "The dealer has a #{dealer_hand[1][1]} of #{dealer_hand[1][0]} showing"

end

def ask_to_stay_or_hit(total_decks, hand)
  begin
  puts "Do you want to (S)tay or (H)it?"
  player_call = gets.chomp.downcase
  if player_call == "h"
  deal_card!(total_decks,hand)
  else
  check_for_winner(hand)
  end
  end while player_call != "s"
end



def count_up_cards(hand)

  total = 0
  count = 0
  hand.each do |card|
    current_value = card[1]

    if (current_value == "jack") ||  (current_value == "queen" )  ||  (current_value == "king") || (current_value== "ace")

      face_card_total = convert_face_cards_to_int(current_value, total)
      #hand.each { |card| total += card[1].to_i }
      total = total + face_card_total.to_i
    else
      total = current_value .to_i+ total

    end

  end
  return total
  puts total
end

  # case total
  # when total > 21
  #   ace = 1
  # when total > 21
  #   ace = 11



  # when total <= 16

  # end
  # puts card_count

  # # hand.each do |card|
  # #   card_sum = hand[count][2]

  # #count player_hand[count][2]

  # end

def convert_face_cards_to_int(current_card,total)
  if (current_card == "jack" ) || (current_card == "queen") || (current_card == "king")
    current_card = 10
    return current_card
  else
    if total > 21
      return 1
      binding.pry
    else
      return 11
    end
  end
end




  # puts "You have a {player_hand["

# def sum_hand(hand)
#   hand_total =

def check_for_winner(hand)
  total = count_up_cards(hand)
  p total
  if total == '21'
    put you win!
  else
  end




end





number_of_decks = determine_number_of_decks
total_decks = build_decks(number_of_decks)
shuffle_decks!(total_decks)
player_hand  = []
dealer_hand = []
deal_card!(total_decks,player_hand)
deal_card!(total_decks,dealer_hand)
deal_card!(total_decks,player_hand)
deal_card!(total_decks, dealer_hand)





# initial_player_deal(total_decks,player_hand)
# dealer_hand = []
# initial_dealer_deal(total_decks,dealer_hand)

announce_cards(player_hand, dealer_hand)
ask_to_stay_or_hit(total_decks,player_hand)

dealer_total_count = count_up_cards(dealer_hand)
player_total_hand = count_up_cards(player_hand)


# card_num = 0
# begin
#   card_num += 1
#   player_hand[card_num] = deal_card!(total_decks,player_hand)
# end while player_call == "s"
#deal 2 card to player
#ask for hit or stay
#ask for hit or stay until player stops
#dealer takes a card
#dealer decides to stay or hit
#if 16 or under take hit
#if over 17 dealer stays
#count all cards and see who wins







