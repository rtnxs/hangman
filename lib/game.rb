class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.gsub(/[ЁЙ]/, 'Ё' => 'Е', 'Й' => 'И').chars
    @user_guesses = []
  end

  def errors
    return @user_guesses - @letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(letter)
          letter
        else
          nil
        end
      end

    return result
  end

  def lost?
    return errors_allowed == 0
  end

  def over?
    return won? || lost?
  end

  def normalize_letter(letter)
    return "Е" if letter == "Ё"
    return "И" if letter == "Й"
    letter
  end

  def play!(letter)
    letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(letter)
      @user_guesses << letter
    end
  end

  def won?
    return (@letters - @user_guesses).empty?
  end

  def word
    return @letters.join
  end
end
