class Card
  SYMBOLS = { :spade => '♠', :heart => '♡', :diamond => '♢', :club => '♣' }

  attr_reader :cost, :cost1

  def initialize(name, suit, cost)
    @name = name
    @suit = suit
    @cost = cost[0]
    @cost1 = cost[1]
  end

  def to_s
    "#{@name}#{SYMBOLS[@suit]}"
  end
end
