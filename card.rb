class Card
  CARDS = %w(2 3 4 5 6 7 8 9 10 В Д К Т)
  SUITS = %w(♠ ♡ ♢ ♣)

  attr_reader :cost, :name

  def initialize(name, suit, cost)
    @name = name
    @suit = suit
    @cost = cost
  end

  def to_s
    @name + @suit
  end
end
