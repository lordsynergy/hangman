class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.upcase.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map do |letter|
      if @user_guesses.include?(normalize_letter(letter))
        letter
      end
    end
  end

  # Возвращает true, если у пользователя не осталось ошибок, т.е. игра проиграна
  def lost?
    errors_allowed == 0
  end

  # Возвращает true, если игра закончена (проиграна или выиграна)
  def over?
    won? || lost?
  end

  # Если игра не закончена и передаваемая буква отсутствует в массиве
  # введённых букв, то закидывает передаваемую букву в массив "попыток".
  def play!(letter)
    normalized_letter = normalize_letter(letter)

    if !over? && !@user_guesses.include?(normalized_letter)
      @user_guesses << normalized_letter
    end
  end

  # Возвращает true, если не осталось неотгаданных букв (пользователь выиграл)
  def won?
    (normalized_letters - @user_guesses).empty?
  end

  # Возвращает загаданное слово, склеивая его из загаданных букв
  def word
    @letters.join
  end

  private

  # Возвращаем буквы Е, И если пользователь ввел буквы Ё, Й
  def normalize_letter(letter)
    return "Е" if letter == "Ё"
    return "И" if letter == "Й"

    letter
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end
end
