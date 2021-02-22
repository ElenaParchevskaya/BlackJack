class Game
  STAKE = 10

  def main_menu
    print "Как вас называть? :"
    name = gets.chomp
    @slave = Player.new(name, :showed)
    @master = Player.new('Крупье', :hidden)
    @players = [@master, @slave]
    new_game
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}. Игра не началась."
    puts e.backtrace
  end

  private

  def game_over(name)
    puts "У #{name} нет денег на новую игру. Игра закончилась."
  end

  def show_table
    puts "=====+++ Стол +++====="
    puts "Банк #{@bank}"
    @players.each do |p|
      puts "Игрок #{p.to_s}, карты на руках #{p.print_cards}, деньги на руках #{p.money}"
    end
    puts "Сумма моих карт #{@slave.calc_hand}"
  end

  def new_game
    @deck = Deck.new
    @players.each( &:clear_hand )
    2.times do
      @players.each { |p| p.give_card @deck.deck.pop }
    end

    @bank = 0
    @players.each do |p|
      @bank += p.change_money - STAKE
    end

    show_table
    next_turn_menu
  rescue RuntimeError => e
     game_over e.message
  end

  def next_turn_menu
  end
end
