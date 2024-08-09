require 'yaml'
require_relative 'game'
module GameSave
  def save_game
    Dir.mkdir 'saved' unless Dir.exist? 'saved'
    filename = "#{genrate_name}_game.yaml"
    File.open("saved/#{filename}", 'w') { |file| file.write save_to_yaml }
    puts "#{filename} - Saved"
  end

  def genrate_name
    adjective = %w[red pink blue yellow black orange cold hot tiny blast fast dark]
    noun = %w[pie moon key rock hat star tree fork pin tablet trick]
    "#{adjective.sample}_#{noun.sample}_#{rand(11..99)}"
  end

  def save_to_yaml
    YAML.dump(
      'letters_used' => @letters_used,
      'selected_word' => @selected_word,
      'displayed_word' => @displayed_word,
      'game_state' => @game_state,
      'wrong_guesses' => @wrong_guesses
    )
  end

  def find_saved_file
    show_saved_file
    puts "Selecct the file you want to load by entering it's number"
    file_number = nil
    loop do
      file_number = gets.chomp
      break if /\A\d+\z/.match?(file_number) && file_number.to_i <= file_list.length

      puts 'Invalid input'
    end
    @saved_game = file_list[file_number.to_i - 1]
  end

  def show_saved_file
    puts 'Saved Files: '
    file_list.each_with_index do |name, index|
      puts "#{index + 1}. #{name}"
    end
  end

  def file_list
    files = []
    Dir.entries('saved').each do |name|
      files << name if name.match(/(game)/)
    end
    files
  end

  def load_game
    find_saved_file
    load_yaml_files
  end

  def load_yaml_files
    file = YAML.safe_load(File.read("saved/#{@saved_game}"))
    @letters_used = file['letters_used']
    @selected_word = file['selected_word']
    @displayed_word = file['displayed_word']
    @game_state = file['game_state']
    @wrong_guesses = file['wrong_guesses']
  end
end
