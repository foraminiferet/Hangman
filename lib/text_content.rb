module TextContent
  def separator
    '--------------------------------'
  end

  def enter_guess_message
    'Enter your guess: '
  end

  def input_warrning
    'You can only enter letters a-z in this game. Please try again'
  end

  def wrong_guess_message(guess)
    "#{guess}, woops wrong guess."
  end

  def game_won_message
    'You won, congradulations!'
  end

  def game_lost_message
    'You lost, better luck next time!'
  end

  def secret_word(word)
    "The secret word was #{word}"
  end

  def game_feedback(letters)
    "Letters used: #{letters.join(', ')}"
  end

  def game_instructions
    <<~HEREDOC
      --------------------------------------------------------------------------
        1. The object of the game is to guess the computer generated word
        2. You need to guess the word before the hangman picture is complete
        3. 7 wrong guesse will lead to your loss
        4. At the beggining of the game you will be shown _ (empty slots) equal
        to the number of letter in a word
        5. Each wrong guess will generate a hangamn part
        6. Each corret guess will reveal a letter
        7. If at any point you want to save the game just type: "save_game"
      --------------------------------------------------------------------------
    HEREDOC
  end

  def picture(wrong_guesses)
    case wrong_guesses
    when 0
      puts <<~HEREDOC
            __________
            |         |
            |
            |
            |#{'           '}
            |
        __________

        --------------------------------
      HEREDOC
    when 1
      puts <<~HEREDOC
            __________
            |         |
            |         O
            |
            |#{'           '}
            |
        __________

        --------------------------------
      HEREDOC
    when 2
      puts <<~HEREDOC
            __________
            |         |
            |         O
            |         |
            |#{'           '}
            |
        __________

        --------------------------------
      HEREDOC
    when 3
      puts <<~HEREDOC
            __________
            |         |
            |         O
            |         |/
            |#{'           '}
            |
        __________

        --------------------------------
      HEREDOC
    when 4
      puts <<~HEREDOC
            __________
            |         |
            |         O
            |        \\|/
            |#{'           '}
            |
        __________

        --------------------------------
      HEREDOC
    when 5
      puts <<~HEREDOC
            __________
            |         |
            |         O
            |        \\|/
            |         |
            |
        __________

        --------------------------------
      HEREDOC
    when 6
      puts <<~HEREDOC
            __________
            |         |
            |         O
            |        \\|/
            |         |
            |        /
        __________

        --------------------------------
      HEREDOC
    when 7
      puts <<~HEREDOC
            __________
            |         |
            |         O
            |        \\|/
            |         |
            |        / \\
        __________

        --------------------------------
      HEREDOC
    else
      puts 'Error'
    end
  end
end
