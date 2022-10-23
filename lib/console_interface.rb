class ConsoleInterface
  # В константе FIGURES будут лежать все текстовые файлы из папки figures,
  # помещённые в массив. Один элемент массива — одна строка с содержимым целого
  # файла.
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"].
    sort.
    map { |file_name| File.read(file_name) }

  # На вход конструктор класса ConsoleInterface принимает экземпляр класса Game.
  #
  # Экземпляр ConsoleInterface выводит информацию юзеру. При выводе использует
  # статические строки типа "У вас осталось ошибок:" и информацию из экземпляра
  # класса Game, дёргая у него методы, которые мы придумали.
  def initialize(game)
    @game = game
  end

  # Выводит в консоль текущее состояние игры, используя данные из экземпляра
  # класса Game (количество ошибок, сколько осталось попыток и т.д.)
  def print_out
    puts <<~RESULT_GAME
      Слово: #{word_to_show}
      #{figure}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}

    RESULT_GAME

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}"
    end
  end

  # Возвращает ту фигуру из массива FIGURES, которая соответствует количеству
  # ошибок, сделанных пользователем на данный момент (число ошибок берем у
  # экземпляра класса Game)
  def figure
    FIGURES[@game.errors_made]
  end

  # Метод, который готовит слово для вывода "на игровом табло".
  #
  # На вход передали: ["К", "О", nil, "О", nil, nil],
  # на выходе будет: "К О __ О __ __"
  def word_to_show
    @game.letters_to_guess.map { |letter| letter || "__" }.join(" ")
  end

  # Получает массив ошибочных букв и склеивает их в строку вида "Х, У"
  def errors_to_show
    @game.errors.join(", ")
  end

  # Получает букву из пользовательского ввода, приводит её к верхнему регистру
  # и возвращает её
  def get_input
    print "Введите следующую букву:"
    $stdin.gets[0].upcase
  end
end
