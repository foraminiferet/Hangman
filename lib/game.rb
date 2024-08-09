require_relative 'text_content'
require_relative 'game_save'
require 'json'
class Game
  include TextContent
  include GameSave

  MAX_GUESS = 7
  WORD_FILE = 'google-10000-english-no-swears.txt'

  def initialize
    @letters_used = []
    @selected_word = generaterd_random_word
    @displayed_word = @selected_word.chars.map { |_c| '_' }
    @game_state = true
    @wrong_guesses = 0
  end

  def load_game_from_saved
    load_game
    play_game
  end

  def play_game
    puts game_instructions
    puts picture(@wrong_guesses)
    puts @displayed_word.join(' ')
    puts game_feedback(@letters_used)
    turns
    game_over
  end

  private

  attr_accessor :letters_used, :selected_word, :displayed_word, :game_state, :wrong_guesses

  attr_writer

  def turns
    while game_state == true
      break if check_game_state == false

      puts enter_guess_message
      input = input_control
      if input == 'save_game'
        save_game
        next
      end
      update_game(input)
    end
  end

  def update_game(input)
    return if check_game_state(input) == false

    if input.length == 1 && selected_word.include?(input)
      show_letters(input)
    elsif input.length == 1
      letters_used << input
      self.wrong_guesses += 1
    else
      self.wrong_guesses += 1
    end
    display_round_outcome(input)
  end

  def display_round_outcome(input)
    puts separator
    puts picture(wrong_guesses)
    puts displayed_word.join(' ')
    puts game_feedback(letters_used) unless letters_used.empty?
    puts wrong_guess_message(input) unless input.length == 1
  end

  def check_game_state(input = nil)
    return unless selected_word == input || wrong_guesses == MAX_GUESS || selected_word == displayed_word.join('')

    self.game_state = false
  end

  def show_letters(letter)
    indexes = []
    selected_word.each_char.with_index do |char, index|
      indexes << index if char == letter
    end
    indexes.each { |indx| displayed_word[indx] = letter }
  end

  def game_over
    if wrong_guesses != MAX_GUESS
      puts game_won_message
    else
      puts secret_word(selected_word)
      puts game_lost_message
    end
  end

  def input_control
    input = gets.chomp.downcase
    return input if input == 'save_game'
    return input if input.match(/^[a-zA-Z]+$/)

    puts input_warrning
    input_control
  end

  def generaterd_random_word
    File.readlines(WORD_FILE).map(&:chomp)
        .select { |word| word.length.between?(5, 12) }.sample
  end
end
