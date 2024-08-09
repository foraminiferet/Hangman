require_relative 'lib/game'
require_relative 'lib/text_content'
require_relative 'lib/game_save'

puts 'Welcome to Hangaman'
puts "Would you like to : \n1. Start a new game\n2.Load a game from save"
user_choice = gets.chomp
until %w[1 2].include?(user_choice)
  puts 'Invalid input. Please enter 1 or 2'
  user_choice = gets.chomp
end
user_choice == '1' ? Game.new.play_game : Game.new.load_game_from_saved
