class Player
  MAX_SCORE = 21
  NAME_FORMAT = /^[a-zа-я ]+$/i.freeze

  attr_reader :money

  def initialize(name, type)
   	@name = name
    @money = 100
    @type_default = type
    validate!
  end

  def calc_hand
    score = 0
    @hand.each { |card| score += card.cost }
    @hand.each do |card|
      score += card.cost1 if card.cost1 > 0 && (score + card.cost1 <= MAX_SCORE)
    end
    score
  end

  def change_money(val)
    @money += val
    raise @name if @money < 0
    -val
  end

  def give_card(card)
    @hand << card
  end

  def clear_hand
    @hand = []
    @type = @type_default
  end

  def print_cards
    str = ''
    num = 0
    @hand.each do |card|
      card_symbol = @type == :showed ? card.to_s : '**'
      str += "#{num}:#{card_symbol} "
    end
    str
  end

  def to_s
    @name
  end

  private

  def validate!
   raise "Имя слишком короткое!" if @name.length < 1
   raise "Имя некорректное, можно только буквы и пробелы" if @name !~ NAME_FORMAT
  end
end
