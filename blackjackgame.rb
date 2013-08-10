# Interactive command line blackjack game

def calculate_total(cards) 
  # [['Hearts', '3'], ['Spades', 'Queen'], ... ]
  arr = cards.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == 'Ace'
      total += 11
    elsif value.to_i == 0 # Jack, Queen, King
      total += 10
    else
      total += value.to_i
    end
  end

  #  Correct for Aces
  arr.select{|e| e == 'Ace'}.count.times do
    total -= 10 if total > 21
  end

  total
end

#  Start Game

puts ''
puts 'Hello, Welcome to Blackjack!'

suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

deck = suits.product(cards)
deck.shuffle!

# Deal Cards

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

# Show Cards

puts "Your dealer has these cards: #{dealercards[0]} and #{dealercards[1]}, which add up to #{dealertotal}"
puts "You have these cards: #{mycards[0]} and #{mycards[1]}, which add up to #{mytotal}"
puts ""

#  Player Turn

if mytotal == 21
  puts 'Congratulations!!! You hit blackjack! You win!' #When my total is equal to 21, exit the program.
  exit
end

while mytotal < 21
  puts 'You can either press 1 to hit or 2 to stay!'
  hit_or_stay = gets.chomp

  if !['1','2'].include?(hit_or_stay)
    puts 'Error: Invalid number, please press 1 or 2!'
    next #Go to the next loop in this while loop
  end

  if hit_or_stay == '2'
    puts "Ok, so you are sticking with #{mytotal}."
    break #To break out of loop
  end

# Press 1 to hit
if hit_or_stay == '1'
  puts 'Pick a card!'
end

  new_card = deck.pop
  puts "You are now being dealt another card.  Your card is #{new_card}"
  mycards << new_card #Appending new card into my cards array
  mytotal = calculate_total(mycards)
  puts "You now have a total of #{mytotal}"

  if mytotal == 21
    puts 'Congratulations!!! You hit blackjack! You win!' #When my total is equal to 21, exit the program.
    exit
  elsif mytotal > 21
    puts 'You lose! Better luck next time!'
    exit
  end
end

#  Dealer Turn

if dealertotal == 21
  puts 'You lose! Dealer hit blackjack!!'
  exit
end

while dealertotal < 17 #Because dealer only hits if less than 17, and stays if over 17.
  #hit
  new_card = deck.pop
  puts "A new card is now being dealt for the dealer.  That card is #{new_card}."
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "The dealer now has a total of #{dealertotal}."

  if dealertotal == 21
    puts 'You lose! Dealer hit blackjack!!'
    exit
  elsif dealertotal > 21
    puts 'Congrats!! You Win!! Dealer has busted!'
    exit
  end
end

#  Compare hands

puts " These are the dealer's cards: "
dealercards.each do |card|
  puts " => #{card}"
end
puts ""

puts "And, these are your cards:"
mycards.each do |card|
  puts "=> #{card}"
end
puts ""

if dealertotal > mytotal
  puts 'So sorry! But, the dealer has won!'
elsif dealertotal < mytotal
  puts 'Congrats!!! You win!!!'
else
  puts 'Noone wins! it\'s a tie!'
  exit
end

exit


