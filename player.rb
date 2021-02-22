class Player
  MAX_SCORE = 21
  NAME_FORMAT = /^[a-zа-я ]+$/i.freeze

  attr_writer :type
  attr_reader :money, :type_default

  def initialize(name, type)
   	@name = name
    @money = 100
    @type_default = type
    validate!
  end

  def max_cards?
    true if @hand.count == 3
  end

  def allowed_add_card?
    true if @hand.count == 2
  end

  def overscore?
    calc_hand > MAX_SCORE
  end

  def change_money(val)
    @money += val
    raise @name if @money < 0

    -val
  end

  def give_card(deck)
    @hand << deck.deck.pop if @hand.count < 3
  end

  def clear_hand
    @hand = []
    @type = @type_default
  end

  def print_cards
    str = ''
    @hand.each do |card|
      card_symbol = @type == :showed ? card.to_s : '**'
      str += "#{card_symbol} "
    end
    str
  end

  def calc_hand
    score = 0
    @hand.each { |card| score += card.cost }
    @hand.each do |card|
      score += card.cost1 if card.cost1 > 0 && (score + card.cost1 <= MAX_SCORE)
    end
    score
  end

  def show_score
    @type == :showed ? calc_hand : '???'
  end


  def to_s
    @name
  end

  private

  def validate!
   raise 'Имя слишком короткое!' if @name.length < 1
   raise 'Имя некорректное, можно только буквы и пробелы' if @name !~ NAME_FORMAT
  end
end
