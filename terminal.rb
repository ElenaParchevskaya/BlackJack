class TerminalInterface
  LINE1 = "----------------------------------------------------"
  LINE2 = "===================================================="

  attr_accessor :game

  def start_game
    loop do
      puts LINE1
      puts "Новый раунд"
      @game.turn_new_init
      loop do
        show_table
        @turn_stop = 0
        slave
        master if @turn_stop == 0
        @turn_stop = 1 if @game.turn_stop?
        if @turn_stop == 1
          turn_end
          break
        end
      end
    end
  rescue RuntimeError => e
    game_over e.message
  end

  def turn_end
    puts LINE2
    puts 'Текущий раунд закончился'
    show_table(true)
    winner = @game.turn_end
    if winner.nil?
      puts "Ничья\n\n\n"
    else
      puts "Выиграл #{winner}\n\n\n"
    end
  end

  def slave
    puts '1 - если хотите пропустить ход'
    puts '2 - если хотите добавить карту' if @game.slave_add_card?
    puts '3 - если хотите открыть карты'
    print 'Ваш ход : '
    case gets.chomp.to_i
    when 2
      @game.turn_slave
      @turn_stop = 1 if @game.slave_overscore?
      show_table
    when 3 then @turn_stop = 1
    end
  end

  def master
    puts "Ход игрока #{@game.master.to_s}"
    if @game.turn_master
      puts 'Беру карту'
    else
      puts 'Пропускаю ход'
    end
  end

  def show_error(e)
    puts "Возникла ошибка #{e.message}."
    puts e.backtrace
  end

  def break_game
    puts ''
    puts 'Введите 1 для того, чтобы начать еще раз'
    gets.chomp.to_i != 1
  end

  def input_name
    puts 'Как вас называть? :'
    gets.chomp
  end

  private

  def show_table(change_master = false)
    @game.change_master_view if change_master
    puts LINE2
    puts "Стол\n"
    puts "Банк #{@game.bank}"
    @game.players.each do |p|
      puts "Игрок #{p}, карты на руках #{p.print_cards}, сумма карт #{p.show_score}, деньги на руках #{p.money}"
    end
    puts
  end

  def game_over(name)
    puts LINE2
    puts "У #{name} закончились деньги. Гейм овеееер."
    puts LINE2
  end
end
