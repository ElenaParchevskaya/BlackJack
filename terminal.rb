require_relative 'hand.rb'

class TerminalInterface

  attr_accessor :game

  def start_game
    loop do
      distribution_of_cards
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
    winner = @game.turn_end
    if winner.nil?
      puts "Ничья\n"
    else
      puts "Выиграл #{winner}\n"

    end
    return if ask_one_more? == 1
    exit
  end

  def slave
    puts "\nТвой ход!"
    puts '1 - пропустить ход'
    puts '2 - добавить карту' if @game.slave_add_card?
    puts '3 - открыть карты'
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

  def input_name
    puts "\nКак вас называть? :"
    gets.chomp
  end

  private

  def show_table(change_master = false)
    @game.change_master_view if change_master
    puts "\n\n\nБанк #{@game.bank}"
    @game.players.each do |p|
      puts "#{p} - #{p.print_cards}, #{p.show_score} очков,   ( #{p.money} $)"
    end
    puts
  end

  def distribution_of_cards
    processing("\nРаздача карт")
  end

  def processing(sign)
    print sign
    20.times do
      print '.'
      sleep 0.1
    end
    puts
    puts
  end

  def ask_one_more?
    puts "\nСыграем еще?"
    puts '1 - Да'
    puts '2 - Нет'
    gets.chomp.to_i
  end

  def game_over(name)
    puts "\nУ #{name} закончились деньги. Гейм овеееер."
  end
end
