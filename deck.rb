require_relative 'card.rb'
class Deck

  attr_reader :deck

  def initialize
    @deck = []
    Card::CARDS.each do |c|
      Card::SUITS.each do |s|
        @deck << Card.new(c, s, cost(c))
      end
    end
    @deck.shuffle!
  end

  def take_card
    @deck.pop
  end

  private

  def cost(c)
    return c.to_i if c.to_i > 1

    return 11 if c == 'Т'

    10
  end
end
